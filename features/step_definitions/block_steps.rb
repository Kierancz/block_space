Given(/^the user visits a story they can edit$/) do
	visit stories_path
	fill_in "Title",    with: "New Story Title"
  	fill_in "Description", with: "Description"
  	click_button "Create New Story"
  	visit stories_path
  	first('.list-group-item').click
end

When(/^the user fills out the new block form and presses submit$/) do
  fill_in "block_content",    with: "Test Block"
  click_button "Create"
end

Then(/^their block should be added to the story$/) do
  expect(page.has_content?("Test Block"))
end

When(/^the user clicks on a block's delete button$/) do
  first('.btn-danger').click
end

Then(/^the block is removed from the story$/) do
  page.should_not have_content("Test Block")
end

When(/^the user clicks on a block's edit button$/) do
  first('.btn-warning').click
end

Then(/^the user should be taken to the block edit page$/) do
  expect(page.has_content?("Editing Block"))
  expect(page.has_content?("Test Block"))
end

When(/^the user changes changes the block contents and presses Save Changes$/) do
  fill_in "block_content",    with: "Edited Block"
  click_button "Save changes"
end

Then(/^the block conents should have changed$/) do
  expect(page.has_content?("Edited Block"))
end

