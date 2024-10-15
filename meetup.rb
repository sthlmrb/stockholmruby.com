require "time"
require "date"

Meetup = Data.define(:name, :url, :time, :description, :venue_name, :venue_address) do
  def self.upcoming
    all.select { |meetup| meetup.time.to_date >= Date.today }
  end

  def self.past
    all.select { |meetup| meetup.time.to_date < Date.today }
  end

  def self.all
    [
      new(
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
