FactoryGirl.define do
  sequence(:username) {|n| "person#{n}" }
  sequence(:email) {|n| "person#{n}@gmail.com" }

  factory :user do
    username
    email
    password "foobar69"
    password_confirmation "foobar69"
  end

  factory :story do
  	title 		"Test Title"
  	description 	"Test Story Description"
  	user
  end

  factory :block do
    user
    story
  	content		"Test data for block content"
  	association :story_id, :factory => :story
  end

  factory :invalid_block do
    content "Just Content"
  end
end