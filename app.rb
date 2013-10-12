require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

require_relative "meetup"

get "/styles.css" do
  scss :styles
end

get "/" do
  events = Meetup.upcoming(5)
  slim :index, locals: {
    next_event: events.first,
    more_events: events[1..-1]
  }
end

get "/organize" do
  slim :organize
end

get "/work" do
  slim :work
end
