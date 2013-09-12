shared_examples 'auto naming' do
  context 'when no name is provided' do
    it 'sets a random name on validations' do
      resource = described_class.new
      expect { resource.valid? }.to change resource, :name
    end
  end

  context 'when name is already provided' do
    it 'sets a random name on validations' do
      resource = described_class.new :name => 'gibberish'
      expect { resource.valid? }.to_not change resource, :name
    end
  end
end