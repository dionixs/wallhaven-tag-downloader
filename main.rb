# frozen_string_literal: true

require 'tty-spinner'
require_relative 'lib/progress_bar'
require_relative 'lib/wallhaven'
require_relative 'lib/downloader'

wallhaven = Wallhaven::Parser.read_config('settings.json')

status = "Search for pictures by given parameters from file: settings.json"

spinner = TTY::Spinner.new("[:spinner] #{status}", format: :classic)

spinner.auto_spin

loop do
  url = wallhaven.open_page
  response = wallhaven.get_request(url)
  break if wallhaven.too_many_request?(response)

  data = wallhaven.json_parse(response)
  break if wallhaven.data_empty?(data)

  wallhaven.parse_images(data)
end

spinner.success('(successful)')

wallhaven.show_finished_status

Wallhaven::Downloader.download_images(wallhaven.tag, wallhaven.urls_images)
