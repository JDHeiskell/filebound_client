RSpec.describe 'Assignments Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_assignment) { client.assignment_new }

  it 'should create a new assignment' do
    expect(new_assignment).to_not be_nil
  end
end
