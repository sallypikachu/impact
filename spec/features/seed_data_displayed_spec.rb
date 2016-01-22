require "rails_helper"

# As an unauthenticated user
# I can see the tables/maps of biodiversity/indicators of human activity

# Acceptance Criteria:
# [ ] When I first go to the home page, a table/chart/map is displayed
# [ ] I can click on different tabs/buttons that will then display
#     different things

feature "visit home page to see tables/charts/maps" do
  scenario "visit home page to see the biodiversity map" do
    biodiversity = Title.create(name: "GEF benefits index for biodiversity")
    year2008 = Year.create(year: 2008)
    brazil = Location.create(country: "Brazil", isocode: "BR")
    japan = Location.create(country: "Japan", isocode: "JP")

    Fact.create([
      { title: biodiversity, year: year2008, location: brazil, data: "100.0" },
      { title: biodiversity, year: year2008, location: japan, data: "36.0" }
    ])
    visit facts_path

    expect(page).to have_content("EF benefits index for biodiversity")
    expect(page).to have_content("Brazil")
    expect(page).to have_content("100.0")
    expect(page).to have_content("Japan")
    expect(page).to have_content("36.0")
  end
end
