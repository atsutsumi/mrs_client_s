# coding: UTF-8

module JmaClient
  
  #
  # JmaClientのメイン処理
  #
  class Main
    
    #
    # 初期化
    #
    def initialize(options)
      @options = options
      @sender = nil
      @receiver = nil
      @log = JmaClient.logger
    end

    #
    # メイン処理開始
    #
    def start
		  @log.info("JmaClientアプリケーション起動...")
      # 送信用スレッド起動
      @sender = Sender.new(@options)
      sender_thread = Thread.new {
  		  @sender.start
      }
      
      # 受信用スレッド起動
      @receiver = Receiver.new(@options)
      # デリゲートインスタンス設定
      @receiver.delegate = @sender
      receiver_thread = Thread.new {
  		  @receiver.start
      }
      
      begin
        # メインスレッドが終了しないように各スレッドを停止
        sender_thread.join
        receiver_thread.join
      rescue Interrupt
        @log.info("JmaClientアプリケーションを終了します。")
      ensure
        # アプリケーション終了時に必要な処理を記載
      end
      
    end
    
  end # Main

end # JmaClient
