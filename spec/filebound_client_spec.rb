RSpec.describe FileboundClient do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:login_failed_client) do
    FileboundClient::Client.connect(host: config[:host],
                                    username: 'nouser',
                                    password: 'nopassword')
  end

  it 'has a version number' do
    expect(FileboundClient::VERSION).not_to be nil
  end

  it 'should login' do
    expect(client.connection.token).not_to be_empty
  end

  it 'should fail to login' do
    expect { login_failed_client }.to raise_error(FileboundClient::Client::FileboundClientException)
  end
end
