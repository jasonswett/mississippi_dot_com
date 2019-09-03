#!/usr/bin/env ruby

require 'sshkit'
require 'sshkit/dsl'
include SSHKit::DSL

require 'net/http'
require 'json'
require 'securerandom'

SSHKit::Backend::Netssh.configure do |ssh|
  ssh.connection_timeout = 30
  ssh.ssh_options = {
    forward_agent: true,
    user: 'ec2-user',
    keys: %w(/Users/jasonswett/.ssh/jasonci.pem)
  }
end

SSHKit.config.output_verbosity = :debug

uri = URI('http://www.suitemagic.io/api/v1/instances')
response = Net::HTTP.get(uri)

hosts = JSON.parse(response).map do |instance|
  instance['public_hostname']
end

test_file_paths = (`find #{Dir.getwd}/spec -name '*_spec.rb'`)
  .split("\n")
  .map { |f| f.gsub(/#{Dir.getwd}\//, '') }

puts "Number of test files: #{test_file_paths.count}"
puts "Number of available EC2 instances: #{hosts.count}"

mappings = {}

hosts[0..([test_file_paths.count, hosts.count].min - 1)].each_with_index do |host, index|
  mappings[host] = test_file_paths[index]
end

on mappings.keys, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    puts host
    file_path = mappings[host]
    execute :sudo, "docker-compose run web bundle exec rspec #{file_path}"
    execute :suite_magic, "$(curl http://169.254.169.254/latest/meta-data/instance-id) #{file_path} $?"
  end
end

puts "#{test_file_paths.count} test files"
