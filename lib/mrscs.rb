# coding:utf-8

require "yaml"
require "log4r"
require "log4r/yamlconfigurator"
require "active_support/core_ext"
require "stringio"

require_relative 'mrscs/main'
require_relative 'mrscs/sender'
require_relative 'mrscs/receiver'
require_relative 'mrscs/util'
require_relative 'mrscs/socket'
require_relative 'mrscs/header_helper'


#
# Mrscsアプリケーションのベースとなるモジュールです。各種共通メソッドとアプリケーション開始メソッドを保持します。
#
module Mrscs

  # Mrscsアプリケーション用ロガーインスタンスを取得します。
  # ==== Args
  # ==== Return
  # _Log4r_ :: 
  # ==== Raise
   def self.logger
    @logger ||= Log4r::Logger["Log4r"] 
    return @logger
  end


  # Mrscsアプリケーション用の各種設定を取得します。
  # ==== Args
  # ==== Return
  # _Hash_ :: アプリケーション設定を保持します。
  # ==== Raise
  def self.get_mrscs_config
    @mrscs_config ||= Util.get_yaml_config("mrscs_config.yml")
  end
  
  # ロガーインスタンス用Log4rインスタンスを作成します。
  # ==== Args
  # ==== Return
  # _Log4r_ :: 
  # ==== Raise
  def self.load_log_config
    if Log4r::Logger["log4r"].nil?
      Log4r::YamlConfigurator.load_yaml_file(File.join(Util.get_config_path(__FILE__), "log4r.yml"))
    end
  end
  
  # Mrscsアプリケーションを開始します。
  # ==== Args
  # ==== Return
  # ==== Raise
  def self.start_mrscs
    load_log_config
    config = get_mrscs_config
    Main.new(config).start
  end

end # Mrscs

	
#
# Stringクラス拡張
#
class String
   
  # 2進文字列をバイナリに変換します。
  # ==== Args
  # ==== Return バイナリ文字列
  # ==== Raise
  def bit2bin
    s = self
    s.scan(/......../).map{ |b| 
    b.to_i(2) }.pack('C*')
  end
  
  # バイナリを2進文字列に変換します。
  # ==== Args
  # ==== Return
  # _String_ :: 2進文字列
  # ==== Raise
  def bin2bit
    self.unpack('b*').map{ |b| "%02X" % b }.join('')
  end
end
