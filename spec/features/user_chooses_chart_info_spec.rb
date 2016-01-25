require "rails_helper"

# As an authenticated user
# I want to contribute

# Acceptance Criteria:
# [ ] There is a choose data to display button
# [ ] When I select my data to display a graph is displayed

feature "sees profile in top bar" do
  scenario "user visits choose data page" do
    visit root_path
    click_link "Lets go!"

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
    visit root_path
    click_link "Lets go!"
    select "Algeria", from: "country"
    select "Population density (people per sq. km of land area)", from: "title"
    click_on "Display data"

    expect(page).to have_content("Population density (people per sq. km of land area)")
    expect(page).to have_content("Brazil")
  end
end
