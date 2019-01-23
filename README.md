# FileboundClient

This gem provides a easy way for you to access the Filebound API.

[![Build Status](https://travis-ci.org/JDHeiskell/filebound_client.svg?branch=master)](https://travis-ci.org/JDHeiskell/filebound_client)

## Dependencies

### Development
* Ruby
* Bundler
* Rake
* Yard - for documentation
* RSpec - for testing

### Runtime
* Ruby
* httpi - this gem provides the ability to send NTLM headers in requests for when your Filebound server is running
          on an IIS web site with Windows Authentication enabled.
* rubyntlm - this gem is required by the httpi gem to support NTLM headers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filebound_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filebound_client

## Usage

Once you have the gem install you will need to configure it before you can connect to the Filebound API.  
Here is an example:

```ruby
require 'filebound_client'
c = FileboundClient::Client.connect(host: url_to_api, username: fb_username, password: fb_password)
```

If your Filebound server uses domain auth you will need to add some additional configuration values:

```ruby
require 'filebound_client'
c = FileboundClient::Client.connect(host: url_to_api, username: fb_username, password: fb_password, use_ntlm: true, 
                                    ntlm_user: ntlm_username, ntlm_password: ntlm_password, ntlm_domain: ntlm_domain)
```

Once you have a connection you can start making requests to the API

## Examples

### Get a project

```ruby
p = c.project(123)
puts p[:name]
```

### Create a project

```ruby
p = c.project_new
p[:name] = 'Test Project'
project_id = c.project_add(p)
p = c.project(project_id)
puts p[:name]
```

### Update a project

```ruby
p = c.project(123)
puts p[:name]
p[:name] = 'something else'
project_id = c.project_update(p)
p = c.project(project_id)
puts p[:name]
```

### Create a file

```ruby
p = c.project(123)
f = c.file_new
f[:projectId] = p[:id]
f[:notes] = 'test file'
```

If you have field values you need to set for indexing set them this way.  The first element in the array is not used.  
Element 1 is the first indexed field.

```ruby
f[:field] = ["not used - ignore", "test value", "", "", "", "", "", "", "", "", "", "", "", "", 
             "", "", "", "", "", "", ""]
```

Then save your new file this way.

```ruby
file_id = c.file_add(f)
f = c.file(file_id)
puts f[:notes]
```

### Update a file

```ruby
f = c.file(123)
f[:notes] = 'updated notes'
file_id = c.file_update(f)
f = c.file(file_id)
puts f[:notes]
```

### Create document with attached binary file data

```ruby
data = Base64.encode64(File.read('somefile.pdf'))
d = c.document_new
d[:allowSaveBinaryData] = true
d[:binaryData] = data
d[:extension] = 'pdf'
d[:fileId] = 123
d[:description] = 'Test PDF file'
d[:name] = 'somefile.pdf'
d[:notes] = 'Test PDF'
document_id = c.document_add(d)
d = c.document(document_id)
puts d[:name]
```

Set the isImage field to true if the file is an image (png, jpg, gif, etc).
Set the isText field to true if the file is a text file.
Set the isTIFF field to true if the file is as TIFF file.
Set the isWeb field to true if the file is and HTML file (HTM, HTML, etc).
Set the isWebEform field to true if the file is an HTML form.

### Update document

```ruby
d = c.document(123)
puts d[:name]
d[:name] = 'different name'
document_id = c.document_update(d)
d = c.document(document_id)
puts d[:name]
```

### Create document and assign it to a workflow and user

Here is a more detail example of a more complex API interaction.
This example shows how you can create a file, a document in the file and then
assign that document to a workflow and then a user. Obviously this a quick example
and still requires null checks and exception handling.

First create your [file](#create-a-file).
Then create your [document](#create-document-with-attached-binary-file-data).
Then build out the routed item and update it:

```ruby
user = c.users(filter: 'name_someuser').first
project = c.projects(filter: 'name_someproject').first
route = c.project_routes(project[:id], filter: 'name_someroute', hiddenRoutes: true).first
routed_item = c.route_document_to_workflow(route[:id], d[:id], 'test note')
routed_item[:userId] = user[:id]
routed_item[:userName] = user[:name]
routed_item_id = c.routed_item_update(routed_item)
```

### Send an additional filter in the querystring

The FileBound API also gives you the ability to send an additional filter on certain calls to further filter 
a GET result by any of the fields in the resource.  See below for an example:

```ruby
u = c.users(filter: 'name_someusername')
puts u[:displayName]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Setup your Filebound connection information
in a test.yml file.  You can see an example in example_test.yml.  Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the 
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### New resource endpoints

If you are creating a new resource endpoint there are a couple of macros you can use for creating a new empty
resource and getting all instances of a resource on the Filebound server.  Here is an example from the assignments 
resource endpoint file:

```ruby
module FileboundClient
  module Endpoints
    module Assignments
      def self.included klass
        klass.instance_eval do
          allow_new :assignment  # Creates a new empty assignment
          allow_all :assignments # Request all assignments with an optional filter query parameter
        end
      end
      ...
    end
  end
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JDHeiskell/filebound_client.  Our contributing
guidelines can be found [here](./CONTRIBUTING.md).

## Code of Conduct

We enforce the standard [Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct.  You can access
that [here](./CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). A copy
of it is [here](./LICENSE.txt).
