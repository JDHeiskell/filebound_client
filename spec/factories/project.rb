module Factories
  module ProjectFactory
    def build_project(client)
      p = client.projects(filter: 'name_TestProject')
      return p.first unless p.empty?
      p = client.project_new
      p[:name] = 'TestProject'
      project_id = client.project_add(p)
      client.project(project_id)
    end
  end
end
