require 'yaml'

require 'cogwheels/configuration'

module Cogwheels
  # This module helps in writing YAML files from Configuration instances
  module Writer
    class << self
      def write(config, file)
        File.open(file, 'w') do |f|
          f.write(config.hash.to_yaml)
        end
      end
    end
  end
end
