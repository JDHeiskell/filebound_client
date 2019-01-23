module Factories
  module DocumentFactory
    def build_document(client, file_path, file_id)
      d = client.documents(filter: "name_Testdocument.txt,fileId_#{file_id}")
      return d.first unless d.empty?
      d = client.document_new
      data = Base64.encode64(File.read(file_path))
      d[:name] = 'Testdocument.txt'
      d[:allowSaveBinaryData] = false
      d[:binaryData] = data
      d[:extension] = 'txt'
      d[:fileId] = file_id
      d[:description] = 'Test Text file'
      d[:notes] = 'Test file'
      document_id = client.document_add(d)
      client.document(document_id)
    end

    def destroy_document(client, document_id)
      client.document_delete(document_id)
    end
  end
end
