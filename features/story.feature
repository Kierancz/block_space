Feature: Create a new story

	Scenario: Create new story
        Given a user is signed in
        And the user visits the stories page
        When the user fills out the new story form and presses submit
        Then they should be taken to their new story