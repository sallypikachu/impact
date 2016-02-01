require "rails_helper"

# As an unauthenticated user
# I want to see what is on the learn tab

# Acceptance Criteria:
# [ ] There is interesting data displayed

feature "sees interesting chart data" do
  scenario "user visits learn page" do
    visit root_path
    click_link "Learn"

    expect(page).to have_content("Checkout out interesting data!")
  end
end
