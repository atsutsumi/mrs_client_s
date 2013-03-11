module JmaClient
  # Utility methods for Lgdisit module
	class Util

		# Retrieves a parent directory path
		# ==== Args
		# _file_path_ :: a file path to get a parent path
		# ==== Return
		# returns the parent path		
		def self.get_config_path(file_path)
			@config_path ||= File.join(get_parent_path(file_path), "config")
			return @config_path
		end

		# Retrieves a path of the directory that contains configuration files 
		# Assumes the relative path of the directory from this module is "../config"
		# ==== Args
		# _file_path_ :: a file path to get the directory path which contains configuration files
		# ==== Return
		# returns the configuration file path		
		def self.get_parent_path(file_path)
			@parent_path ||= File.dirname(File.dirname(File.expand_path(file_path)))
			return @parent_path
		end

		# Retrieves yaml configuration hash values
		# ==== Args
		# yaml file name
		# ==== Return
		# configuration hash values
		def self.get_yaml_config(config_file_name)
				yaml_config ||= YAML.load(File.open(File.join(get_config_path(__FILE__), config_file_name)))
				return yaml_config
		end

		# Gets a bracketed string from the specified string
		# ==== Args
		# _string_ :: the specified string
		# ==== Return
		# a bracketed string
		def self.get_bracketed_string(string)
			return "[" + string + "] "
		end
	end
end
