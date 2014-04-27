require 'spec_helper'
require 'capybara/rspec'

describe "users/show" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "renders attributes" do
    render
    response.should have_content(@user.username)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
