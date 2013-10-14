require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

require_relative "meetup"

set :static_cache_control, [:public, max_age: 3600]

before do
  cache_control :public, max_age: 600
end

get "/styles.css" do
  scss :styles
end

get "/" do
  slim :index, locals: event_data
end

get "/organize" do
  slim :organize
end

get "/work" do
  slim :work
end

def event_data
  events = Meetup.upcoming(5)

  {
    next_event: events.first,
    more_events: events[1..-1]
  }
end
