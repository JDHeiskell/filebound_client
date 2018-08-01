module Factories
  module FileFactory
    def build_file(client, project_id)
      f = client.files(filter: "notes_testfile,projectId_#{project_id}")
      return f.first unless f.empty?
      f = client.file_new
      f[:projectId] = project_id
      f[:notes] = 'testfile'
      f[:field] = ['not used - ignore', '123', 'FileBound Rocks!',
                   '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
      file_id = client.file_add(f)
      client.file(file_id)
    end

    def destroy_file(client, file_id)
      client.file_delete(file_id)
    end
  end
end
