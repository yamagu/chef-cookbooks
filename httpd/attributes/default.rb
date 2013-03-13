default[:httpd][:server_name] = "www.example.com"
default[:httpd][:document_root] = "/var/www/html"

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
