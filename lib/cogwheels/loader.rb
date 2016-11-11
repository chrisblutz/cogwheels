require 'yaml'
require 'safe_yaml'

module Cogwheels
  module Loader
    class << self
      def load_from_file(file)
        hash = {}
        if File.exist?(file)
          yaml = IO.read(file)
          hash = safe_load(yaml, file.path)
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
