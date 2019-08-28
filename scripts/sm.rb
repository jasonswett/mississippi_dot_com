#!/usr/bin/env ruby

require 'net/http'
require 'json'

uri = URI('http://www.suitemagic.io/api/v1/instances')
response = Net::HTTP.get(uri)

hosts = JSON.parse(response).map do |instance|
  instance['public_hostname']
end

puts hosts
