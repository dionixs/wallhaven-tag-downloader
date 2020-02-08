# frozen_string_literal: true

require 'byebug'

require 'mechanize'
require 'net/http'
require 'json'

require_relative 'lib/wallhaven'

# чтение конфигурации из файла settings.json
wallhaven = Wallhaven.read_config('settings.json')

# номер текущей страницы
page = 1

# массив ссылок на картинки
urls_images = []

# условие выхода из цикла
condition = nil

puts "Parsing..."

loop do
  url = wallhaven.update_url_parameters(page)

  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  data.each do |key, value|
    if key == "data"
      condition = 0 if value == []
        value.each do |item|
          urls_images << item['path']
        end
      end
  end

  break if condition == 0

  page += 1
end

Wallhaven.download_image(urls_images)