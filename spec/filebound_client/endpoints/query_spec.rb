require 'factories/project'
require 'factories/file'
require 'factories/document'

RSpec.describe 'Query Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_document) { client.document_new }
  let(:project) { build_project(client) }
  let(:file) { build_file(client, project[:id]) }
  let!(:document) { build_document(client, 'test.txt', file[:id]) }

  context 'with generated file and document' do
    after(:each) do
      destroy_file(client, file[:id]) if file[:id] && file[:id] > 0
      destroy_document(client, document[:id]) if document[:id] && document[:id] > 0
    end

    it 'should retrieve a project with files and documents populated' do
      response = client.query('name_TestProject', 'notes_testfile', 'name_Testdocument.txt')
      expect(response[0][:name]).to eq 'TestProject'
      expect(response[0][:files][:collection][0][:notes]).to eq 'testfile'
      expect(response[0][:files][:collection][0][:documents][:collection][0][:name]).to eq 'Testdocument.txt'
    end
  end
end
