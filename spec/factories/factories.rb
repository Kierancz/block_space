FactoryGirl.define do
  factory :user do
    username     "Example User"
    email    "example@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :story do
  	user
  	title 		"Test Title"
  	description 	"This is a test for description"
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
  	content 	nil
  end

end