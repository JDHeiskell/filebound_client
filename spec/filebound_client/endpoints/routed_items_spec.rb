RSpec.describe 'Users Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_routed_item) { client.routeditem_new }

  it 'should create a new routeditem' do
    expect(new_routed_item).to_not be_nil
  end

  it 'should get routeditems' do
    expect(client.routeditems).to_not be_empty
  end
end
