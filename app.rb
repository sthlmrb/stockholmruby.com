require "rubygems"
require "bundler"
require_relative "meetup"

Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

class StockholmRubySite < Sinatra::Base
  set :cache, Dalli::Client.new
  set :cache_enabled, ENV["CACHE_ENABLED"] == "true"
  set :static_cache_control, [:public, max_age: 3600]

  before do
    unless params[:nocache]
      cache_control :public, max_age: 600
    end
  end

  get "/styles.css" do
    cached { scss :styles }
  end

  get "/" do
    cached { slim :index, locals: event_data }
  end

  get "/organize" do
    cached { slim :organize }
  end

  get "/learn" do
    cached { slim :learn }
  end

  get "/work" do
    cached { slim :work }
  end

  get "/chat" do
    cached { slim :chat }
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
      more_events: upcoming_events[1..-1],
      past_events:,
    }
  end

  def cached(ttl = 120, &block)
    return yield unless settings.cache_enabled

    fetch("sthlmrb#{request.path}", ttl, &block)
  end

  def fetch(key, ttl, &block)
    value = settings.cache.get(key)

    if value.nil?
      value = yield
      settings.cache.set(key, value, ttl)
    end

    value
  end
end
