require "spec_helper"

describe "user sign in" do
  it "allows users to sign in after they have registered" do
    user = User.create(:username => "randomtest",
    				   :email    => "randomtest@example.com",
                       :password => "randomtest")

    visit "/users/sign_in"

    fill_in "Email",    :with => "randomtest@example.com"
    fill_in "Password", :with => "randomtest"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end

	it "allows users to sign out after they have signed in" do
        click_button "Sign out"  
    end
end