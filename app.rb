require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'open-uri'
require 'net/http'
require 'json'

get '/' do
    keyword = params[:keyword]
    uri = URI("https://itunes.apple.com/search")
    uri.query = URI.encode_www_form({ term: keyword, country: "US", media: "music", limit: 10})
    res = Net::HTTP.get_response(uri)
    returned_JSON = JSON.parse(res.body)
    @musics = returned_JSON["results"]
    
    erb :index
end