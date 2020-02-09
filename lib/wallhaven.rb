# frozen_string_literal: true

class Wallhaven
  attr_accessor :base_url, :api, :resolution, :tag, :urls_images

  def initialize(params)
    @base_url = params['base_url']
    @api = params['api']
    @resolution = params['resolution']
    @tag = params['tag']
    @page = 0
    @urls_images = []
  end

  def self.read_config(path_to_config)
    abort "Файл #{path_to_config} не найден!" unless File.exist?(path_to_config)

    data = File.read(path_to_config, encoding: 'UTF-8')
    data_json = JSON.parse(data)
    new(data_json)
  end

  def query_search
    query = "&categories=111&purity=110&atleast=#{@resolution}&sorting=relevance&order=desc"
    token = "/apikey=#{@api}"
    @base_url + "q=#{@tag}" + query + token
  end

  def next_page
    @page += 1
    current_page = query_search + "&page=#{@page}"
  end

  def get_response(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return 0 if response.include?('Too Many Requests')

    JSON.parse(response)
  end

  def parse(data)
    data['data'].each do |item|
      @urls_images << item['path']
    end

    return 0 if data['data'].empty?
  end

  def self.download_image(directory_name, urls_images)
    Dir.mkdir('images') unless File.exist?('images')

    puts 'Download images...'

    urls_images.each do |url|
      agent = Mechanize.new
      agent.get(url).save "images/#{directory_name}/#{File.basename(url)}"
    end
  end
end
