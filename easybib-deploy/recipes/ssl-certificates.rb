ssl_dir    = node['ssl-deploy']['directory']

node['deploy'].each do |application, deploy|
  next unless allow_deploy(application, 'ssl', node['ssl-deploy']['ssl-role'])

  unless deploy.key?('ssl_certificate')
    Chef::Log.info("No ssl_certificate 'key'")
    next
  end

  unless deploy.key?('ssl_certificate_key')
    Chef::Log.info("No ssl_certificate_key 'key'")
    next
  end

  if deploy['ssl_certificate'].empty?
    Chef::Log.error('ssl_certificate is empty')
    next
  end

  if deploy['ssl_certificate_key'].empty?
    Chef::Log.error('ssl_certificate_key is empty')
    next
  end

  ssl_certificate_ca = ''

  if deploy.key?('ssl_certificate_ca')
    unless deploy['ssl_certificate_ca'].nil?
      ssl_certificate_ca = deploy['ssl_certificate_ca'].chomp
    end
  end

  ssl_certificate     = deploy['ssl_certificate'].chomp
  ssl_certificate_key = deploy['ssl_certificate_key'].chomp
  ssl_combined_key    = [ssl_certificate, ssl_certificate_key, ssl_certificate_ca].join("\n")

  directory ssl_dir do
    mode      '0750'
    owner     'root'
    group  node['nginx-app']['group']
    recursive true
  end

  template ssl_dir + '/cert.pem' do
    source 'ssl_key.erb'
    mode   '0640'
    owner  'root'
    group  node['nginx-app']['group']
    variables(
      'ssl_key' => ssl_certificate
    )
  end

  template ssl_dir + '/cert.key' do
    source 'ssl_key.erb'
    mode   '0640'
    owner  'root'
    group  node['nginx-app']['group']
    variables(
      'ssl_key' => ssl_certificate_key
    )
  end

  template ssl_dir + '/cert.combined.pem' do
    source 'ssl_key.erb'
    mode   '0640'
    owner  'root'
    group  node['nginx-app']['group']
    variables(
      'ssl_key' => ssl_combined_key
    )
  end

end
