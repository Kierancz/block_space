Feature: Signing in

  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When they submit invalid signin information
    Then they should see an error message

  Scenario: Successful signin
    Given a user visits the signin page
      And the user has an account
    When the user submits valid signin information
    Then they should see their profile page
      And they should see a signout link

  Scenario: Sign out
    Given a user visits the signin page
    And the user has an account
    When the user submits valid signin information
    Then they should see their profile page
    And they should see a signout link
    When the user presses the signout link
    Then the user will be on the index page