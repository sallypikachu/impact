require "rails_helper"

# As an authenticated user
# I want to sign in so that I can access the system

# Acceptance Criteria:
# [ ] There is an option to sign in on the page if I'm not already authenticated
# [ ] My password is not displayed as I enter it
# [ ] I must specify a valid email address
# [ ] If I've entered the right credentials, I receive an onscreen message that
#     I'm signed in, and I've gained access to the system
# [ ] If I didn't enter valid credentials, I receive an error message and I am
#     left unauthenticated
# [ ] If I'm already authenticated, I don't have the option to sign in

feature "sees profile in top bar" do
  let!(:user) { User.create(username: "user", email: "user@email.com", password: "password") }

  scenario "user visits index page" do
    sign_in_as(user)

    click_link "Profile"
    expect(page).to have_content("Edit Credentials")
  end
end
