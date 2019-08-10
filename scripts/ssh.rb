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

on ["ec2-18-223-30-210.us-east-2.compute.amazonaws.com"], in: :parallel do |host|
  puts "Now executing on #{host}"
  within "/home/ec2-user/mississippi_dot_com" do
    as 'ec2-user' do
      with RAILS_ENV: 'test' do
        execute :sudo, 'docker-compose run web bundle exec rspec'
      end
    end
  end
end
