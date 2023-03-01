require "ostruct"

class Meetup
  class Result < OpenStruct; end

  def self.upcoming
    [
      Result.new(
        name: "Ruby GAME SHOW meetup",
        url:  "https://www.cloudamqp.com/blog/ruby-game-show-meetup.html",
        time: Time.parse("2023-03-16 18:00 CEST"),
        description: "We are excited to welcome you to the Ruby Game Show Meetup in Stockholm! Join us at 6 pm on March 16 for a fantastic evening with a mix of games, talks, food, and drinks. In addition, you can meet other developers and make new connections in the industry.",
        venue_name:    "Gasverket/United Spaces",
        venue_address: "Torsgatan 25, Stockholm",
      )
    ]
  end
end
