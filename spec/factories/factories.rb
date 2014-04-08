FactoryGirl.define do
  factory :user do
    username     "Example User"
    email    "example@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end