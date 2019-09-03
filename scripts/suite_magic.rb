#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'securerandom'

BASE_URL = "http://www.suitemagic.io/api/v1"
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

puts Net::HTTP.post(uri, JSON.generate(params), 'Content-Type' => 'application/json')
