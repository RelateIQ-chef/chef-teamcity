action :install do
  service "teamcity-server" do
    supports start: true, stop: true, restart: true
    action :nothing
  end

  plugins_dir = "#{node[:teamcity][:data_path]}/plugins"

  directory plugins_dir do
    owner node[:teamcity][:user]
  end


  if new_resource.local_file_name.to_s == ''
    local_file_path = "#{plugins_dir}/#{::File.basename(new_resource.url)}"
  else
    local_file_path = "#{plugins_dir}/#{new_resource.local_file_name}"
  end

  unless ::File.exist?(local_file_path)
    remote_file local_file_path do
      source new_resource.url
      owner node[:teamcity][:user]
      action :create_if_missing
      notifies :restart, "service[teamcity-server]"
    end

    new_resource.updated_by_last_action(true)
  end
end
