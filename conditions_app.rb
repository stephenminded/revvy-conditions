require 'sinatra'
require './conditions'
require 'json'

get '/conditions.json' do
  conditions.to_json
end
