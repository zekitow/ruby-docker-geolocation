  settings = YAML::load(File.read('./config/database.yml'))[$env]

  configure $env.to_sym do
    ActiveRecord::Base.establish_connection(settings)
  end
