Feature: Create a new story

	Scenario: Create new story
        Given a user is signed in
        And the user visits the stories page
        When the user fills out the new story form and presses submit
        Then they should be taken to their new story

    Scenario: Edit a story
        Given a user is signed in
        And the user visits the stories page
        When the user fills out the new story form and presses submit
        Then they should be taken to their new story
        When the user presses the Edit Story button 
        Then they should be taken to the Edit Story page
        When the user edits the story description and presses save
        Then the story's description should have changed

    Scenario: Delete a story
        Given a user is signed in
        And the user visits the stories page
        When the user fills out the new story form and presses submit
        Then they should be taken to their new story
        When the user presses the Edit Story button 
        Then they should be taken to the Edit Story page
        When the user clicks the delete story button
        Then the story should be deleted

    Scenario: Add and remove collaborator
        Given a user is signed in
        And the user visits the stories page
        When the user fills out the new story form and presses submit
        Then they should be taken to their new story
        When the user presses the Edit Story button 
        Then they should be taken to the Edit Story page
        When the user enters a users email to the collaboration box and clicks add
        Then the new collaborator will be added to the list
        When the user clicks the collaborators delete button
        Then the collaborator will be removed from the list