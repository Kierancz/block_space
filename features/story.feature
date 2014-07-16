Feature: Create a new space

	Scenario: Create new space
        Given a user is signed in
        And the user visits the spaces page
        When the user fills out the new space form and presses submit
        Then they should be taken to their new space

    Scenario: Edit a space
        Given a user is signed in
        And the user visits the spaces page
        When the user fills out the new space form and presses submit
        Then they should be taken to their new space
        When the user presses the Edit Space button 
        Then they should be taken to the Edit Space page
        When the user edits the space description and presses save
        Then the space's description should have changed

    Scenario: Delete a space
        Given a user is signed in
        And the user visits the spaces page
        When the user fills out the new space form and presses submit
        Then they should be taken to their new space
        When the user presses the Edit Space button 
        Then they should be taken to the Edit Space page
        When the user clicks the delete space button
        Then the space should be deleted

    Scenario: Add and remove collaborator
        Given a user is signed in
        And the user visits the spaces page
        When the user fills out the new space form and presses submit
        Then they should be taken to their new space
        When the user presses the Edit Space button 
        Then they should be taken to the Edit Space page
        When the user enters a users email to the collaboration box and clicks add
        Then the new collaborator will be added to the list
        When the user clicks the collaborators delete button
        Then the collaborator will be removed from the list

    Scenario: Add a non-existent collaborator and one that already exists
        Given a user is signed in
        And the user visits the spaces page
        When the user fills out the new space form and presses submit
        Then they should be taken to their new space
        When the user presses the Edit Space button 
        Then they should be taken to the Edit Space page
        When the user enters a fake users email to the collaboration box and clicks add
        Then the fake collaborator will not be added to the list
        When the user enters the name of a collaborator that already exists and clicks add
        Then the already existing collaborator will not be added to the list again