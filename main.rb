# frozen_string_literal: true

require 'net/http'
require_relative 'lib/wallhaven'
require_relative 'lib/downloader'

wallhaven = Wallhaven::Parser.read_config('settings.json')

puts 'parsing...'

loop do
  url = wallhaven.open_page
  response = wallhaven.get_request(url)
  break if wallhaven.too_many_request?(response)

  data = wallhaven.json_parse(response)
  break if wallhaven.data_empty?(data)

  wallhaven.parse_images(data)
end

Wallhaven::Downloader.download_images(wallhaven.tag, wallhaven.urls_images)
