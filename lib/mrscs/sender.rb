# coding: UTF-8

module Mrscs

  #
  # データ送信用クラス
  #
  class Sender
    
    #
    # 初期化処理
    #
    # ==== Args
    # _options_ :: 設定ファイル内容
    # ==== Return
    # ==== Raise
    def initialize(options)
      @options = options
      @keepalive_interval = options['keepalive_interval']
      @open_interval = options['open_interval']
      @host = options['host']
      @port = options['port']
      @data_mode = options['data_mode']
      @socket = Socket.new(options)
      @log = Mrscs.logger
    end

    #
    # クライアント処理開始
    #
    # ==== Args
    # ==== Return
    # ==== Raise
    def start
      @log.info("データ送信スレッド開始...")
      
      # サーバに接続
      request_open
      
      while true
        sleep(@keepalive_interval)
        begin
          # 一定間隔でヘルスチェック
          @log.info("ヘルスチェックを実施")
          is_health = @socket.healthcheck
          # ヘルスチェックでエラーが発生した場合は再接続
          unless is_health
            @log.warn("ヘルスチェックでエラーが発生しました。#{@open_interval}後に再度接続します...")
            sleep(@open_interval)
            request_open
          end
        rescue => exception
          @log.warn("ヘルスチェックでエラーが発生しました。#{@open_interval}後に再度接続します...")
          sleep(@open_interval)
          request_open
        end
      end
    end

    #
    # サーバに接続する
    #
    # ==== Args
    # ==== Return
    # ==== Raise
    def request_open
      while true
        begin
          @log.info("JMA受信サーバにソケット接続します。 host->[#{@host}] port->[#{@port}]")
          @socket.open(@host, @port)
        rescue => err
          @log.warn("JMA受信サーバへのソケット接続に失敗しました。#{@open_interval}後に再度接続します...")
          # 接続失敗時は指定時間スリープ
          sleep(@open_interval)
          retry
        end
        break
      end
      true
    end
    
    #
    # サーバへ送信要求を行う
    #
    # ==== Args
    # _data_ :: 送信データ
    # ==== Return
    # ==== Raise
    def request_send(data)
      begin
        # data_modeの設定によりデータをそのまま送るかヘッダを付与するか判定
        if @data_mode == 0
          @log.info("データにヘッダを付与せず送信します。")
          @socket.write(data)
        elsif @data_mode == 1
          @log.info("データにJMAヘッダを付与して送信します。")
          jmaheader_added_data = HeaderHelper.add_jma_header(data)
          @socket.write(jmaheader_added_data)
        elsif @data_mode == 2
          @log.info("データにBCHとJMAヘッダを付与して送信します。")
          bchheader_added_data = HeaderHelper.add_bch_header(data)
          jmaheader_added_data = HeaderHelper.add_jma_header(bchheader_added_data)
          @socket.write(jmaheader_added_data)
        end
      rescue => err
        @log.error(err)
        @log.error("JMA受信サーバへのデータ送信に失敗しました。データの再送は行いません。")
      end
    end
    
  end # Sender

end # Mrscs