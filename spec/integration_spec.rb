require "spec_helper"
require "capybara/rspec"
require_relative "../app"
Capybara.app = Sinatra::Application.new

feature "Integrated pages", type: :feature do
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
