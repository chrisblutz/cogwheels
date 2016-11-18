module Cogwheels
  # This class contains configuration information loaded from YAML sources
  class Configuration
    class ImmutableConfigurationError < StandardError
    end

    attr_reader :mutable

    def initialize(hash, mutable = true)
      @hash = {}
      hash.each do |key, value|
        if value.is_a?(Hash)
          value_config = Configuration.new(value, mutable)
          @hash[key] = value_config
        else
          @hash[key] = value
        end
      end
      @mutable = mutable
    end

    def [](key, default = nil)
      @hash[key] ||= default
    end

    def []=(key, value)
      unless @mutable
        error = <<-EOF
A modification was attempted on an immutable Configuration instance.
      EOF
        raise ImmutableConfigurationError, error
      end
      @hash[key] = value if @mutable
    end

    def key?(key)
      @hash.key?(key)
    end

    def keys
      @hash.keys
    end

    attr_reader :hash

    def to_s
      @hash.to_s
    end

    def inspect
      "Cogwheels::Configuration (mutable: #{mutable}) =>\n#{@hash}"
    end

    def ==(other)
      hash == other.hash && mutable == other.mutable
    end
  end
end
