#!/usr/bin/env ruby

require 'json'

command = 'aws ec2 run-instances --profile=personal --launch-template LaunchTemplateId=lt-0ce14fe3496d931df,Version=1'
info = JSON.parse(`#{command}`)

puts info['Instances'][0]['InstanceId']
