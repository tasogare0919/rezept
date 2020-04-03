app_path = File.expand_path("..", __dir__)
directory app_path
environment "production"
# daemonize
pidfile "#{app_path}/tmp/pids/puma.pid"
state_path "#{app_path}/tmp/pids/puma.state"
# stdout_redirect "#{app_path}/log/app.log", "#{app_path}/log/error.log", true
threads 0, 16
bind "unix://#{app_path}/tmp/sockets/puma.sock"
activate_control_app
