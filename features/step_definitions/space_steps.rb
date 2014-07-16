Given(/^a user is signed in$/) do
  visit '/users/sign_in'
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Given(/^the user visits the spaces page$/) do
  visit spaces_path
end

When(/^the user fills out the new space form and presses submit$/) do
  fill_in "Title",    with: "New Space Title"
  fill_in "Description", with: "The New Space Description"
  click_button "Create New Space"
end

Then(/^they should be taken to their new space$/) do
  expect(page.has_content?("New Space Title"))
end

When(/^the user presses the Edit Space button$/) do
  click_button "Edit Space"
end

Then(/^they should be taken to the Edit Space page$/) do
  expect(page.has_content?("Editing: New Space Title"))
end

When(/^the user edits the space description and presses save$/) do
  fill_in "space_description",    with: "Edited Space Description"
  click_button "Save Changes"
end

Then(/^the space's description should have changed$/) do
  expect(page.has_content?("Edited Space Description"))
end

When(/^the user clicks the delete space button$/) do
  click_button "Delete Space"
end

Then(/^the space should be deleted$/) do
  expect(page.has_content?("Space 'New Space Title' has been deleted."))
  page.should_not have_content("The New Space Description")
end

When(/^the user enters a users email to the collaboration box and clicks add$/) do
  @user2 = User.create(username: "bob", email: "bob@example.com",
                      password: "foobar", password_confirmation: "foobar")
  fill_in "user_username", with: "bob"
  click_button "Add"
end

Then(/^the new collaborator will be added to the list$/) do
  page.find('.list-group').should have_content("bob@example.com")
end

When(/^the user clicks the collaborators delete button$/) do
  page.find('.list-group-item', :text => 'bob').find('.glyphicon').click
end

Then(/^the collaborator will be removed from the list$/) do
  page.should_not have_content("bob - bob@example.com")
end

When(/^the user enters a fake users email to the collaboration box and clicks add$/) do
  fill_in "user_username", with: "fake"
  click_button "Add"
end

Then(/^the fake collaborator will not be added to the list$/) do
  page.should have_content("Error: Username 'fake' does not exist")
end

When(/^the user enters the name of a collaborator that already exists and clicks add$/) do
  fill_in "user_username", with: "Example User"
  click_button "Add"
end

Then(/^the already existing collaborator will not be added to the list again$/) do
  page.should have_content("Error: User 'Example User' is already a collaborator")
end
