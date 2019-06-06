RSpec.describe 'Groups Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_group) { client.group_new }

  it 'should create a new group' do
    expect(new_group).to_not be_nil
  end

  it 'should get groups' do
    expect(client.groups).to_not be_empty
  end

  it 'should get a single group' do
    expect(client.group(1)).to_not be_empty
  end

  it 'should get a list of projects assigned to a group' do
    expect(client.group_projects(1)).to_not be_empty
  end
end