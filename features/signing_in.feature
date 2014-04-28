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

  Scenario: Create an account
    Given a user wants to make an account and visits the sign up page
    When the user enters his/her information and presses Create my account
    Then his/her account will be created

  Scenario: A user wants to change their password
    Given a user is logged in and wants to change their password
    When the user clicks the settings button
    Then they will be directed to the Update your profile page
    When the user types in a new password and presses Save changes
    Then their password will be changed