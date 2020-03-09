require 'mechanize'
require 'progress'

module Wallhaven
  class Downloader
    def self.download_images(directory_name, urls_images)
      Dir.mkdir('images') unless File.exist?('images')

      urls_images.with_progress('Downloading images from wallhaven.cc').each do |url|
        agent = Mechanize.new
        agent.get(url).save "images/#{directory_name}/#{File.basename(url)}"
      end

      ProgressBar.print_status(save_path(directory_name))
    end

    private

    def self.save_path(directory_name)
      "Pictures saved to: current_folder_path/images/#{directory_name}"
    end
  end
end