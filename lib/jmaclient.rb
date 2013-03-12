# coding:utf-8

require "yaml"
require "log4r"
require "log4r/yamlconfigurator"
require "active_support/core_ext"
require "stringio"

require_relative 'jmaclient/main'
require_relative 'jmaclient/sender'
require_relative 'jmaclient/receiver'
require_relative 'jmaclient/util'
require_relative 'jmaclient/socket'
require_relative 'jmaclient/header_helper'


#
# アプリケーションメイン
#
module JmaClient

  # Gets Jmaclient system logger.
  # ==== Return
  # log4r logger
   def self.logger
    @logger ||= Log4r::Logger["Log4r"] 
    return @logger
  end


  # Retrieves the jma server configuration hash values
  # ==== Return
  # configuration hash values
  def self.get_jma_client_config
    @jma_client_config ||= Util.get_yaml_config("jmaclient_config.yml")
  end

  # Sets up the configuration for log output.
  def self.load_log_config
    if Log4r::Logger["log4r"].nil?
      Log4r::YamlConfigurator.load_yaml_file(File.join(Util.get_config_path(__FILE__), "log4r.yml"))
    end
  end
  
  def self.start_jmaclient
    load_log_config
    config = get_jma_client_config
    Main.new(config).start
  end

end # JmaClient
