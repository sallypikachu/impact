require "rails_helper"

# As an unauthenticated user
# I can see the tables/maps of biodiversity/indicators of human activity

# Acceptance Criteria:
# [ ] When I first go to the home page, a table/chart/map is displayed
# [ ] I can click on different tabs/buttons that will then display
#     different things

feature "visit home page to see tables/charts/maps" do
  scenario "visit home page to see the biodiversity map" do
    visit root_path

    expect(page).to have_content("About")
    expect(page).to have_content("Created to inspire curiousity about how we, humans, have impacted the world. Click through and select what sets of data you want to compare. Hopefully you will learn something new and it sets you on a path to learn more about society, behavior, and the environment.")
  end
end
