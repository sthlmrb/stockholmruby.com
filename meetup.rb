require "open-uri"
require "json"
require "timeout"
require "ostruct"

class Meetup
  class Result < OpenStruct
    def time
      Time.at(super / 1000)
    end
  end

  def self.upcoming(count)
    key  = ENV["MEETUP_KEY"]

    return [] unless key

    url  = "https://api.meetup.com/2/events?&sign=true&group_urlname=sthlmrb&page=#{count}&key=#{key}"
    json = Timeout.timeout(5) { open(url).read }
    data = JSON.parse(json)

    data["results"].map { |x|
      Result.new(
        name: x["name"],
        url:  x["event_url"],
        time: x["time"],
        description: x["description"],
        venue_name:    x["venue"]["name"],
        venue_address: x["venue"]["address_1"]
      )
    }
  rescue TimeoutError
    []
  end
end
