# coding: UTF-8

module JmaClient

  class Sender
    
    #
    # 初期化処理
    #
    def initialize(options)
      @options = options
      @keepalive_interval = options['keepalive_interval']
      @connect_interval = options['connect_interval']
      @host = options['host']
      @port = options['port']
      @data_mode = options['data_mode']
      @socket_client = SocketClient.new(options)
      @log = JmaClient.logger
    end
    
    #
    # 処理開始
    #
    def start
      @log.info("データ送信スレッド開始...")
      
      # サーバに接続
      request_connect
        
      while true
        sleep(@keepalive_interval)
        begin
          # 一定間隔でヘルスチェック
          @log.info("ヘルスチェックを実施")
          is_health = @socket_client.healthcheck
          # ヘルスチェックでエラーが発生した場合は再接続
          unless is_health
            @log.warn("ヘルスチェックでエラーが発生したため再度ソケット接続から再開します...")
            sleep(@keepalive_interval)
            request_connect
          end
        rescue => exception
          @log.warn("ヘルスチェックでエラーが発生したため再度ソケット接続から再開します...")
          sleep(@keepalive_interval)
          request_connect
        end
      end
    end

    #
    # サーバに接続
    #
    def request_connect
      while true
        begin
          @log.info("JMA受信サーバにソケット接続します。 host->[#{@host}] port->[#{@port}]")
          @socket_client.open(@host, @port)
        rescue => exception
          @log.warn("JMA受信サーバへのソケット接続に失敗しました。#{@connection_interval}後に再度接続します...")
          # 接続失敗時は指定時間スリープ
          sleep(@connect_interval)
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
          @socket_client.write(data)
        elsif @data_mode == 1
          # TODO ヘッダを作成して送信依頼
        end
      rescue => exception
        @log.warn("JMA受信サーバへのデータ送信に失敗しました。データの再送は行いません。")
      end
    end
    
  end # Sender

end # JmaClient