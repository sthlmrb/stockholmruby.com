require "spec_helper"
require "capybara/rspec"

require_relative "../app"

Capybara.app = StockholmRubySite.new
Dotenv.load

feature "Integrated pages", type: :feature do
  before(:all) do
    if ENV["MEETUP_KEY"]
      puts "Integrating with Meetup API using key from .env!"
    else
      puts "Integrating without Meetup API!"
    end
  end

  scenario "Visiting start page" do
    visit "/"
    expect(page).to have_content("Stockholm Ruby")
  end

  scenario "Visiting 'organize' page" do
    visit "/"
    click_link "Organize"
    expect(current_path).to eq("/organize")
    expect(page).to have_content("Organize")
  end

  scenario "Visiting 'work' page" do
    visit "/"
    click_link "Find a job"
    expect(current_path).to eq("/work")
    expect(page).to have_content("Work")
  end
end
