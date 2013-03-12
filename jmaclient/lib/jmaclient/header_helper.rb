# coding: UTF-8

module JmaClient
  
  @@bch_config = {}
  
  #
  # 送信データにヘッダを付与するためのヘルパークラス
  # 
  class HeaderHelper

    #
    # JMAヘッダを付与
    #
    def self.add_jma_header(data, type)
      # 8桁の文字列に変換(先頭は0埋め)
      str_length = format("%08d", data.length)
      # データ作成
      "#{str_length}#{type}#{data}"
    end

    #
    # BCHヘッダを付与
    #
    def self.add_bch_header(data)
      
      # BCH定義ロード
      @@bch_config ||= Util.get_yaml_config("bch_config.yml")
      
      # BCHヘッダ用文字列作成
      str_bch = ''
      str_bch = "#{str_bch}#{@@bch_config['version']}"
      str_bch = "#{str_bch}#{@@bch_config['size']}"
      str_bch = "#{str_bch}#{@@bch_config['reserve1']}"
      str_bch = "#{str_bch}#{@@bch_config['sequence_no']}"
      str_bch = "#{str_bch}#{@@bch_config['relay_type']}"
      str_bch = "#{str_bch}#{@@bch_config['earthquake_flg']}"
      str_bch = "#{str_bch}#{@@bch_config['reserve2']}"
      str_bch = "#{str_bch}#{@@bch_config['test_flg']}"
      str_bch = "#{str_bch}#{@@bch_config['xml_flg']}"
      str_bch = "#{str_bch}#{@@bch_config['degree_of_secrecy']}"
      str_bch = "#{str_bch}#{@@bch_config['data_attribute']}"
      str_bch = "#{str_bch}#{@@bch_config['distribute_info']}"
      str_bch = "#{str_bch}#{@@bch_config['data_type']}"
      str_bch = "#{str_bch}#{@@bch_config['reserve3']}"
      str_bch = "#{str_bch}#{@@bch_config['bif_resend_flg']}"
      str_bch = "#{str_bch}#{@@bch_config['bif_data_attribute']}"
      str_bch = "#{str_bch}#{@@bch_config['bif_data_type']}"
      str_bch = "#{str_bch}#{@@bch_config['an_length']}"
      str_bch = "#{str_bch}#{@@bch_config['checksum']}"
      str_bch = "#{str_bch}#{@@bch_config['send_agency_major']}"
      str_bch = "#{str_bch}#{@@bch_config['send_agency_bit']}"
      str_bch = "#{str_bch}#{@@bch_config['send_agency_termno']}"
      str_bch = "#{str_bch}#{@@bch_config['recv_agency_major']}"
      str_bch = "#{str_bch}#{@@bch_config['recv_agency_bit']}"
      str_bch = "#{str_bch}#{@@bch_config['recv_agency_termno']}"
      
      # BCHヘッダをバイナリ化して付与
      bin_bch = to_bin(str_bch)
      "#{bin_bch}#{data}"
    end
    
    #
    # BCHヘッダをバイナリデータに変換するためのユーティリティメソッド
    #
    def self.to_bin(str)
      # StringIOの機能でバイナリ化する
      sio = StringIO.new()
      
      # 8文字ずつ文字列を取得しバイナリデータ化する
      (0..str.length).step(8) do |s|
        i = str[s,8].to_i(2)
        sio.putc(i)
      end

      # IOのカーソルを先頭に戻し先頭からバイナリデータを取得
      sio.pos = 0
      ret_str = sio.gets
      ret_str.force_encoding("ASCII-8BIT")
      
      return ret_str
    end

  end # HeaderHelper

end # JmaClient