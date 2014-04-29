FactoryGirl.define do
  factory :user do
    username "foobar"
    email "foobar@gmail.com"
    password "foobar69"
    password_confirmation "foobar69"
  end

  factory :story do
  	title 		"Test Title"
  	description 	"Test Story Description"
  	user
  end

  factory :block do
  	content		"Test data for block content"
  	association :story_id, :factory => :story
    user
    story
  end
end