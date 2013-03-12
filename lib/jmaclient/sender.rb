# coding: UTF-8

module JmaClient

  class Sender
    
    #
    # 初期化処理
    #
    def initialize(options)
      @options = options
      @keepalive_interval = options['keepalive_interval']
      @open_interval = options['open_interval']
      @host = options['host']
      @port = options['port']
      @data_mode = options['data_mode']
      @socket = Socket.new(options)
      @log = JmaClient.logger
    end

    #
    # 処理開始
    #
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
    # サーバに接続
    #
    def request_open
      while true
        begin
          @log.info("JMA受信サーバにソケット接続します。 host->[#{@host}] port->[#{@port}]")
          @socket.open(@host, @port)
        rescue => exception
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
    # 送信要求
    #
    def request_send(data)
      begin
        # data_modeの設定によりデータをそのまま送るかヘッダを付与するか判定
        if @data_mode == 0
          @socket.write(data)
        elsif @data_mode == 1
          p 'JMAヘッダを付与'
          added_data = HeaderHelper.add_jma_header(data, "BI")
          @socket.write(added_data)
        elsif @data_mode == 2
          p 'BCHヘッダを付与'
          added_data = HeaderHelper.add_bch_header(data)
          added_data = HeaderHelper.add_jma_header(added_data, "BI")
          @socket.write(added_data)
        end
      rescue => exception
        p exception
        @log.warn("JMA受信サーバへのデータ送信に失敗しました。データの再送は行いません。")
      end
    end
    
  end # Sender

end # JmaClient