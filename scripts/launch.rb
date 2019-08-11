#!/usr/bin/env ruby

require 'json'

LAUNCH_TEMPLATE = 'lt-04347576fe32b0712'

command = [
  'aws ec2 run-instances --profile=personal',
  "--count #{ARGV[0] || 1}",
  "--launch-template LaunchTemplateId=#{LAUNCH_TEMPLATE}"
].join(' ')

puts command
info = JSON.parse(`#{command}`)

info['Instances'].each do |instance|
  puts instance['InstanceId']
end
