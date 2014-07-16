FactoryGirl.define do
  sequence(:username) {|n| "person#{n}" }
  sequence(:email) {|n| "person#{n}@gmail.com" }

  factory :user do
    username
    email
    password "foobar69"
    password_confirmation "foobar69"
  end

  factory :space do
  	title 		"Test Title"
  	description 	"Test Space Description"
  	user
  end

  factory :block do
    user
    space
  	content		"Test data for block content"
  	association :space_id, :factory => :space
  end

  factory :invalid_block do
    content "Just Content"
  end
end