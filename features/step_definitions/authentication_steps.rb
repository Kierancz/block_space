Given /^a user visits the signin page$/ do
  visit '/users/sign_in'
end

When /^they submit invalid signin information$/ do
  click_button "Sign in"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then /^they should see their profile page$/ do
  expect(page.has_content?(@user.username))
end

Then /^they should see a signout link$/ do
  expect(page).to have_link('Sign out', href: destroy_user_session_path)
end

When(/^the user presses the signout link$/) do
  click_link('Sign out', href: destroy_user_session_path)
end

Then(/^the user will be on the index page$/) do
   expect(page.has_content?("Welcome to Blokkspace"))
end

Given(/^a user wants to make an account and visits the sign up page$/) do
  visit signup_path
end

When(/^the user enters his\/her information and presses Create my account$/) do
  fill_in "user_username",                with: "NewUser"
  fill_in "user_email",                   with: "NewUser@gmail.com"
  fill_in "user_password",                with: "password"
  fill_in "user_password_confirmation",   with: "password"
  click_button "Create my account"
end

Then(/^his\/her account will be created$/) do
  expect(User.count == 1)
  expect(page.has_content?("Welcome to Blokkspace"))
end

Given(/^a user is logged in and wants to change their password$/) do
  visit '/users/sign_in'
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

When(/^the user clicks the settings button$/) do
  click_link('Settings')
end

Then(/^they will be directed to the Update your profile page$/) do
  expect(page.has_content?("Update your profile"))
end

When(/^the user types in a new password and presses Save changes$/) do
  fill_in "user_password", with: "password"
  fill_in "user_password_confirmation", with: "password"
  click_button "Save changes"
end

Then(/^their password will be changed$/) do
  expect(page.has_content?("Profile updated"))
end
