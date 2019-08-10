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

URLS = [
  "ec2-3-15-178-9.us-east-2.compute.amazonaws.com",
  "ec2-18-223-30-210.us-east-2.compute.amazonaws.com",
]

on URLS, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    execute :sudo, 'docker-compose run web bundle exec rspec spec/models/author_spec.rb'
  end
end
