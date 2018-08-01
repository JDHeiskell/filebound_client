require 'factories/project'
require 'factories/file'
require 'factories/document'

RSpec.describe 'Documents Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_document) { client.document_new }
  let(:project) { build_project(client) }
  let(:file) { build_file(client, project[:id]) }
  let(:document) { build_document(client, 'test.txt', file[:id]) }

  it 'should create a new document' do
    expect(new_document).to_not be_nil
  end

  context 'with generated file and document' do
    after(:each) do
      destroy_file(client, file[:id]) if file[:id] && file[:id] > 0
      destroy_document(client, document[:id]) if document[:id] && document[:id] > 0
    end

    it 'should add a new document' do
      expect(document).to_not be_nil
    end

    it 'should update a document' do
      document[:notes] = 'test note'
      document_id = client.document_update(document)
      expect(document_id).to be > 0
      updated_document = client.document(document_id)
      expect(updated_document[:notes]).to eq 'test note'
    end
  end
end
