# frozen_string_literal: true

require 'json/ext'

module Wallhaven
  class Parser
    attr_accessor :base_url, :api, :resolution, :tag, :urls_images

    def initialize(params)
      @base_url = params['base_url']
      @api = params['api']
      @categories = params['categories']
      @purity = params['purity']
      @sorting = params['sorting']
      @order = params['order']
      @resolution = params['resolution']
      @tag = params['tag']
      @page = 0
      @urls_images = []
    end

    def self.read_config(path_to_config)
      unless File.exist?(path_to_config)
        abort "File #{path_to_config} does not exist!"
      end

      data = File.read(path_to_config, encoding: 'UTF-8')
      data_json = JSON.parse(data)
      new(data_json)
    end

    def query_search
      query = "&categories=#{@categories}&purity=#{@purity}" \
      "&atleast=#{@resolution}&sorting=#{@sorting}&order=#{@order}"
      token = "/apikey=#{@api}"
      "#{@base_url}q=#{@tag}#{query}#{token}"
    end

    def open_page
      @page += 1
      "#{query_search}&page=#{@page}"
    end

    def get_request(url)
      uri = URI(url)
      Net::HTTP.get(uri)
    end

    def too_many_request?(response)
      response.include?('Too Many Requests')
    end

    def json_parse(response)
      JSON.parse(response)
    end

    def parse_images(data)
      data['data'].each do |item|
        @urls_images << item['path']
      end
    end

    def data_empty?(data)
      data['data'].empty?
    end

    private :query_search
  end
end
