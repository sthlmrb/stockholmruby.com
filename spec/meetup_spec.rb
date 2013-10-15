require "spec_helper"

require_relative "../meetup"

describe Meetup, ".upcoming" do
  before do
    stub_response(
      results: [
        {
          name: "Summit",
          event_url: "http://example.com",
          time: 999999999000,
          description: "Everyone!",
          venue: {
            name: "Globen",
            address_1: "Globentorget 2"
          }
        }
      ]
    )
  end

  it "converts JSON to objects" do
    result = Meetup.upcoming(1, "fake-key").first
    expect(result.name).to eq "Summit"
    expect(result.url).to eq "http://example.com"
    expect(result.time).to eq Time.at(999999999)
    expect(result.description).to eq "Everyone!"
    expect(result.venue_name).to eq "Globen"
    expect(result.venue_address).to eq "Globentorget 2"
  end

  it "returns [] without an API key" do
    results = Meetup.upcoming(1, nil)
    expect(results).to eq []
  end

  def stub_response(hash)
    Meetup.stub_chain(:open, :read) do
      JSON.dump(hash)
    end
  end
end
