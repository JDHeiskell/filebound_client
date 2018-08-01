RSpec.describe 'Separators Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_separator) { client.separator_new }

  it 'should create a new separator' do
    expect(new_separator).to_not be_nil
  end

  it 'should get separators' do
    expect(client.separators).to_not be_empty
  end
end
