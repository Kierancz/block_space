Given(/^the user visits a space they can edit$/) do
	visit '/spaces'
  fill_in "Title",    with: "New Space Title"
	fill_in "Description", with: "Description"
	click_button "Create New Space"
	visit spaces_path
	first('.list-group-item').click
end

When(/^the user fills out the new block form and presses submit$/) do
  fill_in "block_content",    with: "Block 1"
  click_button "Create"
  fill_in "block_content",    with: "Block 2"
  click_button "Create"
end

Then(/^their block should be added to the space$/) do
  expect(page.has_content?("Block 1"))
  expect(page.has_content?("Block 2"))
end

When(/^the user clicks on a block's delete button$/) do
  first('.btn-danger').click
end

Then(/^the block is removed from the space$/) do
  page.should_not have_content("Block 1")
  page.should have_content("Block 2")
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

When(/^the user creates two blocks and presses Insert on the top block$/) do
  fill_in "block_content",    with: "Block 1"
  click_button "Create"
  fill_in "block_content",    with: "Block 2"
  click_button "Create"
  first('.spaceblock').first('.btn-primary').click
end

Then(/^the user should be taken to the Insert Block page$/) do
  expect(page.has_content?("Add a block:"))
end

When(/^the user fills out the form and presses submit$/) do
  fill_in "block_content",    with: "Block 3"
  click_button "Create"
end

Then(/^the block should be inserted between the two existing blocks$/) do
  first_position = page.body.index("Block 3")
  second_position = page.body.index("Block 2")
  first_position.should < second_position
end
