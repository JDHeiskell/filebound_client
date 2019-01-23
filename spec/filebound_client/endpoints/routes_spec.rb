RSpec.describe 'Users Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_route) { client.route_new }

  it 'should create a new route' do
    expect(new_route).to_not be_nil
  end

  it 'should get routes' do
    expect(client.routes).to_not be_empty
  end
end
