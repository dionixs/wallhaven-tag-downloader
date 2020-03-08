require 'mechanize'

module Wallhaven
  class Downloader
    def self.download_images(directory_name, urls_images)
      Dir.mkdir('images') unless File.exist?('images')

      puts 'download images...'

      urls_images.each do |url|
        agent = Mechanize.new
        agent.get(url).save "images/#{directory_name}/#{File.basename(url)}"
      end
    end
  end
end