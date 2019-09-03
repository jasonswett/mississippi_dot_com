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

suite_run_uuid = SecureRandom.uuid
uri = URI("http://www.suitemagic.io/api/v1/suite_runs/#{suite_run_uuid}/test_runs")

# first question:
# can a ruby script just manually hit POST test_runs and create a test run?
# also, there needs to be a place where test runs are viewable

on mappings.keys, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    puts host
    file_path = mappings[host]
    execute :sudo, "docker-compose run web bundle exec rspec #{file_path}"

    #cmd = "-d \"test_run[instance_url]=$(curl http://169.254.169.254/latest/meta-data/instance-id)&test_run[exit_code]=0&test_run[output]=wee&test_run[file_path]=#{file_path}\" -X POST #{uri}"
    #execute :curl, cmd

    # get remote host to hit SM API to create test run - only care about exit code now
  end
end

puts "#{test_file_paths.count} test files"
