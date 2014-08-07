action :deploy do
  app = new_resource.app
  deploy_data = new_resource.deploy_data
  application_root_dir = "#{deploy_data['deploy_to']}/current"

  opsworks_deploy_user do
    deploy_data deploy_data
    app app
  end

  opsworks_deploy_dir do
    user  deploy_data["user"]
    group deploy_data["group"]
    path  deploy_data["deploy_to"]
  end

  opsworks_deploy do
    deploy_data deploy_data
    app app
  end

  easybib_crontab app do
    crontab_file "#{deploy_data['deploy_to']}/current/deploy/crontab"
    app app
  end

  easybib_gearmanw application_root_dir do
    envvar_json_source new_resource.envvar_json_source
  end

  easybib_envconfig app

  new_resource.updated_by_last_action(true)

end
