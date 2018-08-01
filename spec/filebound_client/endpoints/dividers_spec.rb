RSpec.describe 'Dividers Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_divider) { client.divider_new }

  it 'should create a new divider' do
    expect(new_divider).to_not be_nil
  end

  it 'should get dividers' do
    expect(client.dividers).to_not be_empty
  end
end
