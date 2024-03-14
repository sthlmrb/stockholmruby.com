require "ostruct"

class Meetup
  class Result < OpenStruct; end

  def self.upcoming
    [
      Result.new(
        name: "Ruby Meetup with Hemnet",
        url: "https://rubymeetup.confetti.events/signup",
        time: Time.parse("2024-03-13 17:30 CEST"),
        description: "A sparkling event hosted by Ruby fans for Ruby fans in a cozy environment with 🍕 and🧋. Listen to our colleague Olov talking about 'The Journey to a new Map' and Youssef dive into image postprocessing in Ruby.",
        venue_name: "Hemnet",
        venue_address: "Sveavägen 9",
      )
    ]
  end
end
