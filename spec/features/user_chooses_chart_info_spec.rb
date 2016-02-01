require "rails_helper"

# As an authenticated user
# I want to contribute

# Acceptance Criteria:
# [ ] There is a choose data to display button
# [ ] When I select my data to display a graph is displayed

feature "sees profile in top bar" do
  scenario "user visits choose data page" do
    visit root_path
    click_link "Create"

    expect(page).to have_content("What would you like to compare?")
    expect(page).to have_content("Choose 1-3 different data sets for 1 country or 1 data set and multiple countries.")
  end

  scenario "user does not select any data" do
    visit data_path
    click_on "Display data"

    expect(page).to have_content("You didn't choose any datasets/countries?!")
    expect(page).to have_content("What would you like to compare?")
  end

  scenario "user visits choose data page" do
    visit data_path
    select "Population density (people per sq. km of land area)", from: "title"
    select "Canada", from: "country"
    click_on "Display data"

    expect(page).to have_content("Population density (people per sq. km of land area)")
  end

  scenario "user chooses countries that don't have data" do
    visit data_path
    select "Energy use (kg of oil equivalent per capita)", from: "title"
    select "Canada", from: "country"
    select "Anguilla", from: "country"
    click_on "Display data"

    expect(page).to have_content("There are no information on the following countries: Anguilla")
  end

  scenario "user chooses IUCN dataset" do
    visit data_path
    select "Energy use (kg of oil equivalent per capita)", from: "title"
    check "Include data on number of endangered animals?"
    select "World", from: "country"
    click_on "Display data"

    expect(page).to have_content("Endangered Organisms")
    expect(page).to have_content("Extinct encompanies animals that are extinct")
  end
end
