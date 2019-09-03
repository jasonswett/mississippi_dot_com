#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'securerandom'

BASE_URL = "http://www.suitemagic.io/api/v1"
suite_run_uuid = SecureRandom.uuid
uri = URI("#{BASE_URL}/suite_runs/#{suite_run_uuid}/test_runs")

params = {
  test_run: {
    instance_url: ARGV[0],
    file_path: ARGV[1],
    exit_code: ARGV[2],
    output: 'wee'
  }
}

puts Net::HTTP.post(uri, JSON.generate(params), 'Content-Type' => 'application/json')
