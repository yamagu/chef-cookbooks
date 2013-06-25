default[:httpd][:server_name] = "www.example.com"
default[:httpd][:service_enable] = true
default[:httpd][:document_root] = "/var/www/html"
default[:httpd][:allow_override] = "None"
default[:httpd][:allow_hosts] = ["All"]
default[:httpd][:auth][:enabled] = false
default[:httpd][:auth][:name] = "Authentication Required"
default[:httpd][:auth][:type] = "BASIC"
default[:httpd][:auth][:user] = "user"
default[:httpd][:auth][:password] = ""
default[:httpd][:auth][:user_file] = ""
default[:httpd][:satisfy] = "all"

default[:httpd][:mod_ssl][:server_name]            = "www.example.com"
default[:httpd][:mod_ssl][:document_root]          = "/var/www/html"
default[:httpd][:mod_ssl][:certificate_file]       = ''
default[:httpd][:mod_ssl][:certificate_key_file]   = ''
default[:httpd][:mod_ssl][:certificate_chain_file] = ''
default[:httpd][:mod_ssl][:ca_certificate_file]    = ''

default[:httpd][:compress_log][:script_dir]  = '/usr/local/app'
default[:httpd][:compress_log][:log_dir]     = '/var/log/httpd'
default[:httpd][:compress_log][:cron][:enable] = true
default[:httpd][:compress_log][:cron][:hour]   = 4
default[:httpd][:compress_log][:cron][:minute] = 37
