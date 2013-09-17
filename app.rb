require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

get "/styles.css" do
  scss :styles
end

get "/" do
  slim :index
end
