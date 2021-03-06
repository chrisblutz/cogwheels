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
      @hash.freeze unless @mutable
    end

    def [](key, default = nil)
      @hash[key] ||= default
    end

    def []=(key, value)
      if @mutable
        @hash[key] = value
      else
        raise_immutable_configuration_error
      end
    end

    def key?(key)
      @hash.key?(key)
    end

    def keys
      @hash.keys
    end

    def internal_hash
      @hash
    end

    def symbolize_keys
      act_on_keys do |key, value|
        key = key.to_sym
        @new_hash[key] = if value.is_a?(Cogwheels::Configuration)
                           value.symbolize_keys
                         else
                           value
                         end
      end
      self
    end

    def stringify_keys
      act_on_keys do |key, value|
        key = key.to_s
        @new_hash[key] = if value.is_a?(Cogwheels::Configuration)
                           value.stringify_keys
                         else
                           value
                         end
      end
      self
      self
    end

    def act_on_keys
      if @mutable
        @new_hash = {}
        @hash.each do |key, value|
          yield(key, value)
        end
        @hash = @new_hash
      else
        raise_immutable_configuration_error
      end
    end

    def write(file)
      Cogwheels::Writer.write(self, file)
    end

    def hash
      new_hash = {}
      @hash.each do |key, value|
        new_hash[key] = if value.is_a?(Cogwheels::Configuration)
                          value.hash
                        else
                          value
                        end
      end
      new_hash
    end

    def to_s
      @hash.to_s
    end

    def inspect
      "Cogwheels::Configuration (mutable: #{mutable}) =>\n#{@hash}"
    end

    def ==(other)
      hash == other.hash && mutable == other.mutable
    end

    private

    def raise_immutable_configuration_error
      error = <<-EOF
A modification was attempted on an immutable Configuration instance.
      EOF
      raise ImmutableConfigurationError, error
    end
  end
end
