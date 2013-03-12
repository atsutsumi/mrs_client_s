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
# アプリケーションメイン
#
module Mrscs

  # Gets Mrscs system logger.
  # ==== Return
  # log4r logger
   def self.logger
    @logger ||= Log4r::Logger["Log4r"] 
    return @logger
  end


  # Retrieves the Mrscs configuration hash values
  # ==== Return
  # configuration hash values
  def self.get_mrscs_config
    @mrscs_config ||= Util.get_yaml_config("mrscs_config.yml")
  end

  # Sets up the configuration for log output.
  def self.load_log_config
    if Log4r::Logger["log4r"].nil?
      Log4r::YamlConfigurator.load_yaml_file(File.join(Util.get_config_path(__FILE__), "log4r.yml"))
    end
  end
  
  def self.start_mrscs
    load_log_config
    config = get_mrscs_config
    Main.new(config).start
  end

end # Mrscs
