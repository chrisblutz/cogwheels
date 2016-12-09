RSpec.describe Cogwheels::Writer do
  context 'given a Configuration instance' do
    it 'writes to a file correctly' do
      config = Cogwheels::Configuration.new('test' => 'value', 'test_hash' => { 'test2' => 'value2' }).symbolize_keys
      config.write('spec/files/write_test.yml')

      expect(File.exist?('spec/files/write_test.yml')).to eq(true)

      str = ''
      File.open('spec/files/write_test.yml') do |file|
        file.each_line do |line|
          str += line
        end
      end

      expected = config.hash.to_yaml

      expect(str).to eq(expected)
    end
  end
end
