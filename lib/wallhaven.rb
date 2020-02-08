# frozen_string_literal: true

class Wallhaven
  attr_accessor :base_url, :api, :resolution, :tags

  def initialize(params)
    @base_url = params['base_url']
    @api = params['api']
    @resolution = params['resolution']
    @tag = params['tag']
    # @urls_images = []
  end

  def self.read_config(path_to_config)
    data = File.read(path_to_config, encoding: 'UTF-8')
    data_json = JSON.parse(data)
    new(data_json)
  end

  def update_url_parameters(page)
    query = "&categories=111&purity=110&atleast=#{@resolution}&sorting=relevance&order=desc"
    token = "/apikey=#{@api}"
    url = @base_url + "q=#{@tag}" + query + token + "&page=#{page}"
  end

  def self.download_image(urls_images)
    Dir.mkdir 'images' unless File.exist? 'images'

    puts 'Download images...'

    urls_images.each do |url|
      agent = Mechanize.new
      agent.get(url).save "images/#{File.basename(url)}"
    end
  end
end
