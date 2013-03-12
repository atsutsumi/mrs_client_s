# coding: UTF-8

require 'socket'

module Mrscs
  
  #
  # TCPSocketのラッパークラス
  # 
  class Socket

    # ------------------------------------------------------------
    # 定数定義
    # ------------------------------------------------------------
    # ヘルスチェック要求
    HEALTHCHECK_REQUEST = "00000003ENchk"
    # ヘルスチェック応答
    HEALTHCHECK_RESPONSE = "00000003ENCHK"
    # ヘルスチェック電文長
    HEALTHCHECK_LENGTH = 13
    # 電文の最大長
    MAX_BUFFER = 702000
    
    #
    # 初期化処理
    #
    def initialize(options)
      @options = options
      @socket = nil
      @log = Mrscs.logger
    end
    
    #
    # ヘルスチェックを送受信
    #
    def healthcheck
      if @socket.nil?
        raise "ソケットが生成されていないため処理を中断します。"
      end
      
      # ヘルスチェック要求
      @socket.write(HEALTHCHECK_REQUEST)
      
      # ヘルスチェック応答受信
      response = @socket.read(HEALTHCHECK_LENGTH)
      
      # ヘルスチェック応答を解析
      if response == HEALTHCHECK_RESPONSE
        return true
      else
        return false
      end
    end
    
    #
    # サーバとの接続
    #
    def open(host, port)
      # TCPソケットを生成
      @socket = TCPSocket.open(host, port)
    end
    
    #
    # サーバへデータ送信
    #
    def write(data)
      if @socket.nil?
        raise "ソケットが生成されていないため処理を中断します。"
      end
      
      # TCPソケットにデータ送信
      @socket.write(data)
    end
    
  end # Socket

end # Mrscs
