# coding: UTF-8

require 'socket'

module Mrscs
  
  #
  # ソケット接続制御にデータを通知する
  # データはUnixドメインソケットで取得
  #
  class Receiver
    
    attr_accessor :delegate
    
    #
    # 初期化処理
    #
    def initialize(options)
      @options = options
      @sock_path = options['unix_socket']
      # データ受信時のデリゲートクラス
      @delegate = nil
      @log = Mrscs.logger
    end
    
    #
    # 入力スレッド開始
    #
    def start
      @log.info("データ受信スレッド開始...")
      while true
        sleep(0.1)
        
        # 前回のソケットファイルを削除
        if File.exist? @sock_path
          File.unlink @sock_path
        end
        
        # UnixDomainソケットをオープン
        UNIXServer.open(@sock_path) {|serv| # serv->UNIXServerインスタンス
          @log.info("ソケットをオープンしました。")
          
          while true
      			sleep(0.1)
            begin
              @log.info("データ受信待ち...")
              # データを受信
              s = serv.accept
              data = s.read
              @log.info("データを受信しました。データ長->#{data.length}")
              # 受信したデータをデリゲートに通知
              notify_delegate(data)
            rescue => exception
              @log.warn("データ受信待ちでエラーが発生しました。")
            ensure
              unless s.nil?
                s.close
              end
            end
          end
        }
      end
    end
    
    #
    # デリゲート通知
    #
    def notify_delegate(data)
      unless @delegate.nil?
        @delegate.request_send(data)
      end
    end
    
  end # Receiver
  
end # Mrscs
