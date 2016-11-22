RSpec.describe Cogwheels::Configuration do
  context 'when key exists' do
    it 'returns the correct value' do
      config = Cogwheels::Configuration.new(test: 'value')

      expect(config[:test]).to eq('value')
    end
  end

  context 'when value does not exist' do
    it 'returns nil' do
      config = Cogwheels::Configuration.new({})

      expect(config[:test]).to eq(nil)
    end
  end

  context 'when a default value is given and value does not exist' do
    it 'returns the default value' do
      config = Cogwheels::Configuration.new({})

      expect(config[:test, 'default']).to eq('default')
    end
  end

  context 'when a configuration contains a hash' do
    it 'is converted to a configuration instance' do
      config = Cogwheels::Configuration.new(hash: { test: 'value' }, value: 10)

      expect(config[:hash].class).to eq(Cogwheels::Configuration)
    end
  end

  context 'when configuration is mutable' do
    it 'allows changes' do
      config = Cogwheels::Configuration.new(test: 'value')

      expect(config[:test]).to eq('value')

      config[:test] = 'new_value'

      expect(config[:test]).to eq('new_value')
    end
  end

  context 'when configuration is immutable' do
    it 'does not allow changes and raises ImmutableConfigurationError' do
      config = Cogwheels::Configuration.new({ test: 'value' }, false)

      expect(config[:test]).to eq('value')

      expect do
        config[:test] = 'new_value'
      end.to raise_error(Cogwheels::Configuration::ImmutableConfigurationError)
    end
  end

  describe '#to_symbol_keys' do
    it 'converts all keys to symbols' do
      config = Cogwheels::Configuration.new('test' => 'value', 'test_hash' => { 'test2' => 'value2' }).to_symbol_keys

      expect(config[:test]).to eq('value')
      expect(config[:test_hash][:test2]).to eq('value2')
    end
  end

  context 'when configuration is immutable and #to_symbol_keys is called' do
    it 'does not allow changes and raises ImmutableConfigurationError' do
      config = Cogwheels::Configuration.new({ 'test' => 'value' }, false)

      expect do
        config.to_symbol_keys
      end.to raise_error(Cogwheels::Configuration::ImmutableConfigurationError)
    end
  end
end
