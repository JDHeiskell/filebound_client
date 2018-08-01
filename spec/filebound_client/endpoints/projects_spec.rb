require 'factories/project'

RSpec.describe 'Projects Endpoint' do
  let(:config) { YAML.safe_load(File.read('test.yml')).symbolize_keys }
  let(:client) { FileboundClient::Client.connect(config) }
  let(:new_project) { client.project_new }
  let(:project) { build_project(client) }

  it 'should create a new project' do
    expect(new_project).to_not be_nil
  end

  # NOTE: Projects can't be deleted so the first run of a spec in this suite will create the project
  # and each subsequent project run of any spec will use the existing project including each subsequent run of the suite
  context 'with generated project' do
    it 'should update a project' do
      project_to_update = project
      expect(project_to_update[:enableFullText]).to be false
      project_to_update[:enableFullText] = true
      project_id = client.project_update(project_to_update)
      updated_project = client.project(project_id)
      expect(updated_project[:enableFullText]).to be true
      updated_project[:enableFullText] = false
      project_id = client.project_update(updated_project)
      reverted_project = client.project(project_id)
      expect(reverted_project[:enableFullText]).to be false
    end
  end
end
