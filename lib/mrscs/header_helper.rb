# coding: UTF-8

module Mrscs
  
  #
  # 送信データにヘッダを付与するためのヘルパークラス
  # 
  class HeaderHelper
  
    #
    # JMAヘッダを付与
    #
    # ==== Args
    # _data_ :: 送信データ
    # ==== Return
    # _String_ :: JMAヘッダを付与したデータを返却
    # Raise
    def self.add_jma_header(data)
      
      # JMA設定ロード
      @@jma_config ||= Util.get_yaml_config("jma_config.yml")
      
      # データ種別
      message_type = @@jma_config['type']
      
      # 8桁の文字列に変換(先頭は0埋め)
      message_length = format("%08d", data.length)
      
      # データ作成
      "#{message_length}#{message_type}#{data}"
    end

    #
    # BCHヘッダを付与
    #
    # ==== Args
    # _data_ :: 送信データ
    # ==== Return
    # _String_ :: BCHヘッダを付与したデータを返却
    # ==== Raise
    def self.add_bch_header(data)
      
      # BCH定義ロード
      @@bch_config ||= Util.get_yaml_config("bch_config.yml")
      
      # BCHヘッダ用文字列作成
      # 順序が重要なため注意
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
      
      # チェックサム値を作成
      str_bch = gen_checksum(str_bch)
      
      # BCHヘッダをバイナリ化して付与
      bin_bch = str_bch.bit2bin
      
      # TCHヘッダも付与
      header = "#{bin_bch}#{@@bch_config['tch']}"
      
      # dataにヘッダを付与
      "#{header}#{data}"
    end
    
    #
    # 引数のBCH文字列からチェックサム値を作成
    #
    # ==== Args
    # _str_bch :: BCHの2進文字列表現
    # ==== Return
    # _String_ :: 引数にチェックサム値を挿入した文字列
    # ==== Raise
    def self.gen_checksum(str_bch)
      sum = 0
      # BCHを16桁づつ分割し全て加算
      0.upto(9) {|index|
        # チェックサム部分は加算をスキップ
        next if index == 5
        tmp = str_bch[index*16, 16]
        sum = sum + tmp.to_i(2)
      }
      
      # 加算結果を32桁の文字列に変換
      sum = format("%.32b", sum)
      
      # 上位16桁が0になるまで上位16桁を下位16桁に加算
      upper = 0
      under = 0
      loop do
        # 上位16桁を取得
        upper = sum[0, 16].to_i(2)
        under = sum[16,16].to_i(2)
        
        break if upper == 0
        
        # 上位16桁と下位16桁を加算
        tmp_sum = upper + under
        
        # 加算結果を32桁の文字列に変換
        sum = format("%.32b", sum)
      end
      
      # 計算されたチェックサム値
      checksum = format("%16b", ~under&0xFFFF)
      
      # 引数のBCH文字列にチェックサム値を挿入して返却する
      str_bch[80,16] = checksum
      
      return str_bch
    end
    
  end # HeaderHelper
end # JmaClient