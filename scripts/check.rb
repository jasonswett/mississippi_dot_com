#!/usr/bin/env ruby

require 'sshkit'
require 'sshkit/dsl'
include SSHKit::DSL

SSHKit::Backend::Netssh.configure do |ssh|
  ssh.connection_timeout = 30
  ssh.ssh_options = {
    forward_agent: true,
    user: 'ec2-user',
    keys: %w(/Users/jasonswett/.ssh/jasonci.pem)
  }
end

SSHKit.config.output_verbosity = :debug

require 'json'
hosts = JSON.parse(`./scripts/dns_names.sh`).select { |h| h.length > 0 }

on hosts, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    puts host
    execute :which, 'docker-compose'
  end
end
