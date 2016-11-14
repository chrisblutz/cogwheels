require 'yaml'
require 'safe_yaml'

require 'cogwheels/configuration'

module Cogwheels
  # This module helps in loading YAML configurations from different source types
  module Loader
    class << self
      def load(src, mutable = true)
        return Configuration.new(from_file(src), mutable) if File.file?(src)
      end

      def from_file(file)
        hash = {}
        if File.exist?(file)
          yaml = IO.read(file)
          hash = safe_load(yaml, File.path(file))
        end
        hash
      end

      private

      def safe_load(yaml, name)
        SafeYAML.load(yaml, name)
      end
    end
  end
end
