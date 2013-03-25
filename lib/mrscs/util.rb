# coding: utf-8

module Mrscs

  #
  # アプリケーションで共通して使用するユーティリティメソッドを定義します。
  #
	class Util

		# configファイルが保存されているディレクトリパスを取得します。
		# 引数で指定されたパスから "../config" でたどったパスにconfigが保存されていることが前提です。
		# ==== Args
		# _file_path_ :: ディレクトリのパス(String)
		# ==== Return
		# _String_ :: 親ディレクトリのパス
		# ==== Raise
		def self.get_config_path(file_path)
			@config_path ||= File.join(get_parent_path(file_path), "config")
			return @config_path
		end
		
		# 引数で指定されたパスの親ディレクトリのパスを取得します。
		# ==== Args
		# _file_path_ :: ディレクトリのパス(String)
		# ==== Return
		# _String_ :: 親ディレクトリのパス
		# ==== Raise
		def self.get_parent_path(file_path)
			@parent_path ||= File.dirname(File.dirname(File.expand_path(file_path)))
			return @parent_path
		end

		# configディレクトリのYamlファイルをロードしてHash形式で取得します。
		# ==== Args
		# _config_file_name_ :: configファイル名称(configディレクトリ内のファイルであることが前提)
		# ==== Return
		# _Hash_ :: yamlファイル内容
		# ==== Raise
		def self.get_yaml_config(config_file_name)
				yaml_config ||= YAML.load(File.open(File.join(get_config_path(__FILE__), config_file_name)))
				return yaml_config
		end
		
	end  # Util
end # Mrscs
