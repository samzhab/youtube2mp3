#!/usr/bin/env ruby
require 'json'
require 'addressable'
require 'rest-client'
require 'byebug'
require 'yaml'
require 'date'
require 'csv'
# ----------------------------------------------------------------------------
class SearchYouTube
  def start
    puts '[youtube-search] SEARCH YOUTUBE FOR VIDEOS'
    puts '[youtube-search] eg. Ethiopia'
    youtube_api_key = ask_or_load_youtube_apikey
    query = gets.chomp
    query = setup_query(query, youtube_api_key)
    video_ids = get_video_urls(query)
    write_video_ids_to_csv(video_ids)
    puts '[youtube-search] FINISHED PROCESSING'
  end

  def setup_query(query, youtube_api_key)
    week = (DateTime.now - 7).strftime.split('+').first
    # yesterday = (DateTime.now - 1).strftime.split('+').first
    "https://www.googleapis.com/youtube/v3/search?q=#{query}&maxResults=25&part=snippet&publishedAfter=#{week}&key=#{youtube_api_key}".delete(' ').delete("\n")
    #"https://www.googleapis.com/youtube/v3/search?q=#{query}&maxResults=25&part=statistics&publishedAfter=#{week}&key=#{youtube_api_key}".delete(' ').delete("\n")
  end

  def ask_or_load_youtube_apikey
    if local_youtube_api_key?
      YAML.load_file('api_keys/youtube_api_key.yml')
    else
      puts '[youtube-search] ENTER YOU APIKEY'
      api_key = gets.chomp
      save_youtube_api_key(api_key)
      api_key
    end
  end

  def local_youtube_api_key?
    if File.exist?('api_keys/youtube_api_key.yml')
      true
    else
      false
    end
  end

  def save_youtube_api_key(api_key)
    file = File.new('api_keys/youtube_api_key.yml', 'w')
    file.write(api_key.to_yaml)
    file.close
  end

  def get_video_urls(query)
    response = get_request(query, {}, {})
    begin
      json_response = JSON.parse(response.body)
      url_items = []
      json_response['items'].each do |search_result|
        url_items << search_result['id']['videoId']
      end
      return url_items
    rescue JSON::ParserError => e
      puts e
      return nil
    end
  end

  def get_request(url, headers, payload)
    response = RestClient::Request.execute(method: :get, url: Addressable::URI.parse(url).normalize.to_str,headers: headers,
                                           payload: payload,
                                           timeout: 50)
  rescue RestClient::Unauthorized, RestClient::Forbidden => err
    puts 'Access denied!'
    return err.response
  rescue RestClient::BadGateway => err
    puts 'BadGateway!'
    return err.response
  else
    sleep 3
    return response
  end

  def write_video_ids_to_csv(video_ids)
    CSV.open(Dir.pwd + '/csv_files/' + Time.now.to_s, 'wb') do |csv|
      video_ids.each do |id|
        csv << ["https://www.youtube.com/watch?v=#{id}"]
      end
    end
  end
end

search_youtube = SearchYouTube.new
search_youtube.start

# youtube-dl --extract-audio --audio-format mp3 https://www.youtube.com/watch?v=UBaVek2oTtc
