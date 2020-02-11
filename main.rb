# frozen_string_literal: true

require 'byebug'

require 'net/http'
require 'json/ext'

require 'mechanize'

require_relative 'lib/wallhaven'

wallhaven = Wallhaven::Parser.read_config('settings.json')

puts 'parsing...'

loop do
  url = wallhaven.open_page
  data = wallhaven.get_request(url)
  break if data == 0

  result = wallhaven.parse(data)
  break if result == 0
end

Wallhaven.download_image(wallhaven.tag, wallhaven.urls_images)
