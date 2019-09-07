#!/usr/bin/env ruby

require 'net/https'
require 'json'
require 'securerandom'

BASE_URL = "https://www.suitemagic.io/api/v1"

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

suite_run_uuid = ARGV[0]
uri = URI("#{BASE_URL}/suite_runs/#{suite_run_uuid}/test_runs")

params = {
  test_run: {
    instance_url: ARGV[1],
    file_path: ARGV[2],
    exit_code: ARGV[3],
    output: 'wee'
  }
}

request = Net::HTTP::Post.new(uri.request_uri)
request['Content-Type'] = 'application/json'
request.basic_auth('jason', 'sufficientlysecurepassword')
request.body = JSON.generate(params)
response = http.request(request)

puts response.body
