require "rails_helper"

# As an unauthenticated user
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

feature "sees sign in options" do
  let!(:user) { User.create(username: "user", email: "user@email.com", password: "password") }

  scenario "user visits index page" do
    visit root_path
    expect(page).to have_content("Sign In")

    click_link "Sign In"
    expect(page).to have_content("Log in")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Sign up")
  end

  scenario "user succesfully signs in" do
    sign_in_as(user)
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "user successfully signs out" do
    sign_in_as(user)
    click_on "Sign Out"
    expect(page).to have_content("Signed out successfully.")
  end

  scenario "user can sign up" do
    new_user = User.new(username: "new_user", email: "new_user@email.com", password: "password")
    visit root_path
    click_link "Sign In"
    click_on "Sign up"
    fill_in "Username", with: new_user.username
    fill_in "Email", with: new_user.email
    fill_in "Password", with: new_user.password
    fill_in "Password confirmation", with: new_user.password
    click_on "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end
# 
# def sign_in_as(user)
#   visit root_path
#   click_link "Sign In"
#   fill_in 'Email', with: user.email
#   fill_in 'Password', with: user.password
#   click_button 'Log in'
# end
