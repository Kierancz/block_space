Given(/^a user is signed in$/) do
  visit signin_path
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Given(/^the user visits the stories page$/) do
  visit stories_path
end

When(/^the user fills out the new story form and presses submit$/) do
  fill_in "Title",    with: "New Story Title"
  fill_in "Description", with: "Description"
  click_button "Create New Story"
end

Then(/^they should be taken to their new story$/) do
  expect(page.has_content?("New Story Title"))
end
