module Cogwheels
  # This class contains configuration information loaded from YAML sources
  class Configuration
    class ImmutableConfigurationError < StandardError
    end

    attr_reader :mutable

    def initialize(hash, mutable = true)
      @hash = hash
      @mutable = mutable
    end

    def [](key)
      @hash[key]
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

    def to_s
      @hash.to_s
    end

    def inspect
      "Cogwheels::Configuration =>\n#{@hash}"
    end
  end
end
