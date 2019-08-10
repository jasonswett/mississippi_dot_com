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
hosts = JSON.parse(`./scripts/dns_names.sh`)
test_file_paths = (`find #{Dir.getwd}/spec -name '*_spec.rb'`).split("\n").map { |f| f.gsub(/#{Dir.getwd}\//, '') }

puts "Number of test files: #{test_file_paths.count}"
puts "Number of available EC2 instances: #{hosts.count}"

mappings = {}

hosts.each_with_index do |host, index|
  mappings[host] = test_file_paths[index]
end

on mappings.keys, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    execute :sudo, "docker-compose run web bundle exec rspec #{mappings[host]}"
  end
end