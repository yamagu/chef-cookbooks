default['postfix']['mail_type']  = "client"
default['postfix']['myhostname'] = node['fqdn']
default['postfix']['mydomain']   = node['domain']
default['postfix']['myorigin']   = "$myhostname"
default['postfix']['relayhost']  = ""
default['postfix']['mail_relay_networks']        = "127.0.0.0/8"
default['postfix']['relayhost_role']             = "relayhost"
default['postfix']['multi_environment_relay'] = false
default['postfix']['inet_interfaces'] = nil
default['postfix']['virtual_mailbox'] = {
  "enabled" => false,
  "virtual_mailbox_maps" => "hash:/etc/postfix/vmailbox",
  "virtual_uid" => 5000,
  "virtual_gid" => 5000,
  "virtual_mailbox_domains" => "example.com"
}
default['postfix']['virtual_alias_maps'] = {
  "file" => "hash:/etc/postfix/virtual",
  "entry" => {}
}
default['postfix']['smtp_auth'] = {
  "enabled" => false,
  "smtpd_sasl_security_options" => ["noanonymous"]
}
default['postfix']['submission'] = { "enabled" => false }
