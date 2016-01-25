require "rails_helper"

# As an authenticated user
# I want to see what I have contributed

# Acceptance Criteria:
# [ ] There is a profile option
# [ ] I can click an edit credentials link

feature "sees profile in top bar" do
  let!(:user) { User.create(
    username: "user",
    email: "user@email.com",
    password: "password")
  }

  scenario "user visits index page" do
    skip
    sign_in_as(user)

    click_link "Profile"
    expect(page).to have_content("Edit Credentials")
  end
end
