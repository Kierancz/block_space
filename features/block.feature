Feature: Add a block to a story

	Scenario: Create new block
        Given a user is signed in
        And the user visits a story they can edit
        When the user fills out the new block form and presses submit
        Then their block should be added to the story

    Scenario: Delete a block
        Given a user is signed in
        And the user visits a story they can edit
        When the user fills out the new block form and presses submit
        Then their block should be added to the story
        When the user clicks on a block's delete button
        Then the block is removed from the story

    Scenario: Edit a block
        Given a user is signed in
        And the user visits a story they can edit
        When the user fills out the new block form and presses submit
        Then their block should be added to the story
        When the user clicks on a block's edit button
        Then the user should be taken to the block edit page
        When the user changes changes the block contents and presses Save Changes
        Then the block conents should have changed

    Scenario: Insert a block
        Given a user is signed in
        And the user visits a story they can edit
        When the user creates two blocks and presses Insert on the top block
        Then the user should be taken to the Insert Block page
        When the user fills out the form and presses submit
        Then the block should be inserted between the two existing blocks