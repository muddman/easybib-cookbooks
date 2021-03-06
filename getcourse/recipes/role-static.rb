if is_aws
  stack_applications = node['deploy'].keys
else
  stack_applications = %w(consumer domainadmin management signup)
end

stack_applications.each do |app|
  case app
  when 'consumer', 'domainadmin', 'management', 'signup'
    include_recipe 'easybib::role-generic'
    include_recipe 'getcourse-deploy::static'

    listen_opts = (app == 'consumer') ? 'default_server' : ''

    domain_name = ::EasyBib::Config.get_domains(node, app, 'getcourse')
    deploy_dir = ::EasyBib::Config.get_appdata(node, app, 'doc_root_dir')
    app_dir = ::EasyBib::Config.get_appdata(node, app, 'app_dir')

    easybib_nginx app do
      config_template 'static.conf.erb'
      default_router 'index.html'
      domain_name domain_name
      listen_opts listen_opts
      deploy_dir deploy_dir
      nginx_local_conf "#{app_dir}/deploy/nginx.conf"
      notifies :restart, 'service[nginx]', :delayed
    end
  else
    Chef::Log.info('Application #{app} is not a static app, skipping in role-static')
  end
end
