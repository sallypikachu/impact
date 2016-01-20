require "rails_helper"

# As an authenticated user
# I want to contribute

# Acceptance Criteria:
# [ ] There is a add data button
# [ ] I can succesfully add new data


feature "sees profile in top bar" do
  let!(:user) { User.create(
    username: "user",
    email: "user@email.com",
    password: "password")
  }

  scenario "user visits index page" do

    sign_in_as(user)
    click_link "Add new data"

    select "Brazil", from: "fact[location_id]"
    select "GEF benefits index for biodiversity", from: "fact[title_id]"
    select "2008", from: "fact[year_id]"
    fill_in "Data", with: "100.0"
    click_on "Add Data"

    expect(page).to have_content("EF benefits index for biodiversity")
    expect(page).to have_content("Brazil")
    expect(page).to have_content("100.0")
  end
end
