RSpec.describe Cogwheels::Loader do
  context 'given a file' do
    it 'loads the YAML correctly' do
      config = Cogwheels::Loader.load('spec/files/test_config.yml')

      expect(config['Test1']).to eq('test1')
      expect(config['Test2']).to eq(Cogwheels::Configuration.new('Test3' => 'test3', 'Test4' => 4))
    end
  end
end
