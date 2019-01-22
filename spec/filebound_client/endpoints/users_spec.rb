RSpec.describe 'Users Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_user) { client.user_new }

  it 'should create a new user' do
    expect(new_user).to_not be_nil
  end

  it 'should get users' do
    expect(client.users).to_not be_empty
  end
end