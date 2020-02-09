# frozen_string_literal: true

require 'byebug'

require 'mechanize'
require 'net/http'
require 'json'

require_relative 'lib/wallhaven'

wallhaven = Wallhaven.read_config('settings.json')

puts 'Parsing...'

loop do
  url = wallhaven.next_page
  data = wallhaven.get_response(url)
  break if data == 0

  result = wallhaven.parse(data)
  break if result == 0
end

Wallhaven.download_image(wallhaven.tag, wallhaven.urls_images)
