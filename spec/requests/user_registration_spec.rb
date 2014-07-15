require "spec_helper"

describe "user registration" do
  it "allows new users to register with valid information" do
    visit "/users/sign_up"

    fill_in "Username",              :with => "randomtest"
    fill_in "Email",                 :with => "randomtest@example.com"
    fill_in "Password",              :with => "randomtest"
    fill_in "Password confirmation", :with => "randomtest"

    click_button "Create my account"

    page.should have_content("Welcome! You have signed up successfully.")
  end
end