# coding: UTF-8

require 'socket'

module Mrscs
  
  #
  # TCPSocketのラッパークラスです。
  # 
  class Socket

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
    # ==== Args
    # _options_ :: 起動用の設定
    # ==== Return
    # ==== Raise
    def initialize(options)
      @options = options
      @socket = nil
      @log = Mrscs.logger
    end
    
    #
    # サーバに対してヘルスチェック電文を送信します。
    #
    # ==== Args
    # ==== Return
    # _bool_ :: true ヘルスチェック応答あり false ヘルスチェック応答なし
    # ==== Raise
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
    # サーバに対してソケット接続を行います。
    #
    # ==== Args
    # _host_ :: サーバのホスト名またはIPアドレス
    # _port_ :: サーバのポート番号
    # ==== Return
    # _TCPSocket_ :: ソケット接続したソケットインスタンス
    # ==== Raise
    def open(host, port)
      # TCPソケットを生成
      @socket = TCPSocket.open(host, port)
    end
    
    #
    # サーバに対してデータを送信します。
    #
    # ==== Args
    # _data_ :: 送信データ
    # ==== Return
    # ==== Raise
    def write(data)
      if @socket.nil?
        raise "ソケットが生成されていないため処理を中断します。"
      end
      
      # TCPソケットにデータ送信
      @socket.write(data)
    end
    
  end # Socket
end # Mrscs
