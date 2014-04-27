FactoryGirl.define do
  sequence(:username) {|n| "person#{n}" }
  sequence(:email) {|n| "person#{n}@gmail.com" }


  factory :user do
    username
    email
    password "foobar"
    password_confirmation "foobar"
  end

  factory :story do
  	title 		"Test Title"
  	description 	"This is a test for description"
  	user
  end

  factory :invalid_story do
  	description "Test for invalid story"
  end

  factory :block do
  	user
  	story
  	content		"Test data for block content"
  	association :story_id, :factory => :story
  end

  factory :invalid_block do
  	content 
  end

end