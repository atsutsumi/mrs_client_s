# coding: UTF-8

require 'socket'

module JmaClient

  #
  # TCPSocketのラッパークラス
  # 
  class SocketClient
    #
    # 初期化処理
    #
    def initialize(options)
      @options = options
      @max_buffer = options['max_buffer']
      @socket = nil
      @log = JmaClient.logger
    end
    
    #
    # ヘルスチェックを送受信
    #
    def healthcheck
      if @socket.nil?
        raise "ソケットが生成されていないため処理を中断します。"
      end
      
      # ヘルスチェック要求
      @socket.write("00000003ENchk")
      response = @socket.read(13)
      
      # ヘルスチェック応答を解析
      if response == "00000003ENCHK"
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

    #
    # JMAソケットヘッダを付与する
    #
#     def add_header(data, type)
#       # 8桁の文字列に変換(先頭は0埋め)
#       str_length = format("%08d", data.length)
#       # データ作成
#       "#{str_length}#{type}#{data}"
#     end
    
  end # SocketClient
end # Jmaclient
