require 'sinatra'
require 'config_env'
require 'httparty'
require_relative 'models/weather.rb'
require 'uri'
require 'redis'

ConfigEnv.init("#{__dir__}/config/env.rb")
REDIS = Redis.new(url: ENV['REDIS_URL'])

set :port, 3000

get '/' do
  @cities = [
    "Seattle",
    "San Francisco",
    "Denver",
    "Austin",
    "New York",
    "Raleigh"
  ]

  @city = params[:city] || "Seattle"
  @city_class = @city.delete(' ').downcase
  weather = Weather.new(@city)
  @temp = weather.temp
  @icons = weather.icons
  erb :index
end