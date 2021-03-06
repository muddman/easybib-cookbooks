hostname = 'vagrant-machine'

unless node.fetch('opsworks', {}).fetch('instance', {})['hostname'].nil?
  machine_name = node['opsworks']['instance']['hostname']
  stack_name = get_normalized_cluster_name
  hostname = "#{machine_name}.#{stack_name}"
end

template '/etc/monit/conf.d/system.monitrc' do
  source 'system.monit.erb'
  mode   '0644'
  owner  'root'
  group  'root'
  variables(
    'hostname'     => hostname
  )
  notifies :restart, 'service[monit]'
end
