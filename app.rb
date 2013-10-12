require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

require_relative "meetup"

get "/styles.css" do
  scss :styles
end

get "/" do
  slim :index, locals: {
    next_event: Meetup.upcoming(1).first
  }
end

get "/organize" do
  slim :organize
end

get "/work" do
  slim :work
end
