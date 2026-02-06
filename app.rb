require "rubygems"
require "bundler"
require_relative "meetup"

Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

class StockholmRubySite < Sinatra::Application
  set :static_cache_control, [:public, max_age: 3600]

  before do
    unless params[:nocache]
      cache_control :public, max_age: 600
    end
  end

  get "/" do
    slim :index, locals: event_data
  end

  get "/organize" do
    slim :organize
  end

  get "/learn" do
    slim :learn
  end

  get "/work" do
    slim :work
  end

  get "/chat" do
    slim :chat
  end

  get "/install" do
    redirect "http://docs.railsbridge.org/installfest/choose_your_operating_system"
  end

  get "/railsintro" do
    redirect "http://slid.es/gudj/rails-intro-short"
  end

  private

  def event_data
    upcoming_events = Meetup.upcoming
    past_events = Meetup.past

    {
      next_event: upcoming_events.first,
      more_events: upcoming_events[1..],
      past_events:
    }
  end
end
