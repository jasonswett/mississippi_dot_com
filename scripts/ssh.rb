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

#SSHKit.config.output_verbosity = :debug

uri = URI('https://www.suitemagic.io/api/v1/instances')

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth('jason', 'sufficientlysecurepassword')
response = http.request(request)

hosts = JSON.parse(response.body).map do |instance|
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

on mappings.keys, in: :parallel do |host|
  within "/home/ec2-user/mississippi_dot_com" do
    puts host
    file_path = mappings[host]

    execute :sudo, 'docker-compose run web git pull --no-edit'

    last_exit_code = '$?'

    begin
      execute :sudo, "docker-compose run web bundle exec rspec #{file_path}"
    rescue StandardError
      last_exit_code = '1'
    end

    execute :sudo, "docker-compose run web ruby scripts/suite_magic.rb #{suite_run_uuid} $(curl http://169.254.169.254/latest/meta-data/public-hostname) #{file_path} #{last_exit_code}"
  end
end

puts "#{test_file_paths.count} test files"
