require "rails_helper"

# As an authenticated user
# I want to contribute

# Acceptance Criteria:
# [ ] There is a choose data to display button
# [ ] When I select my data to display a graph is displayed

feature "sees profile in top bar" do

  scenario "user visits index page" do
    visit root_path
    click_link "Display different data"

    select "Brazil", from: "Location"
    select "Population density (people per sq. km of land area)", from: "Data sets"
    click_on "Display Data"

    expect(page).to have_content("Population density (people per sq. km of land area)")
    expect(page).to have_content("Brazil")
  end
end
