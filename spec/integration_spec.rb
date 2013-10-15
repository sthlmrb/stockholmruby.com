require "spec_helper"
require "capybara/rspec"
require_relative "../app"
Capybara.app = Sinatra::Application.new

describe "Start page", type: :feature do
  it "renders happily" do
    visit "/"
    expect(page).to have_content("Stockholm Ruby")
  end
end
