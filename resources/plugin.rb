actions :install
default_action :install

attribute :url, kind_of: String, name_attribute: true, required: true

attribute :local_file_name, :kind_of => String, :required => false, :default => ''
