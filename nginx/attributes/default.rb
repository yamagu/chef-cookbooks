default['nginx']['rails-unicorn']['listen']      = "80"
default['nginx']['rails-unicorn']['address']     = "127.0.0.1"
default['nginx']['rails-unicorn']['port']        = "8080"
default['nginx']['rails-unicorn']['server_name'] = "app.example.com"
default['nginx']['rails-unicorn']['root']        = "/path/to/app/current/public"
default['nginx']['rails-unicorn']['error_log']   = "/path/to/app/current/log/error.log"
default['nginx']['rails-unicorn']['serve_assets']   = false
