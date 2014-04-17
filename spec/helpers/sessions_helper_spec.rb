require 'spec_helper'

describe SessionsHelper do
  
  let!(:user) { FactoryGirl.create(:user) }
  
  describe "#sign_in" do
    it "should assign user to @current_user" do
      sign_in(user).should eq(@current_user)
    end
  end
    
  describe "#current_user" do
    it "should return the current_user when signed in" do
      sign_in(user)
      current_user.should eq(user)
    end

    it "should return true against current user" do
      sign_in(user)
      current_user?(user).should eq true
    end
  end
  
  describe "#signed_in?" do
    it "should return true if user is signed in" do
      sign_in(user)
      signed_in?.should eq(true)
    end
    
    it "should return false if use is not signed in" do
      signed_in?.should eq(false)
    end
  end

  describe "#signed_in_user" do
    before do
      visit edit_user_path(user)
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "after signing in" do

      it "should render the desired protected page" do
        expect(page).to have_title('Edit user')
      end
    end
  end

  describe "#signed_in_user 2" do
        before do
          visit signin_path
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        it "should render the default (profile) page" do
          page.should have_content(user.username)
        end
  end

  
  describe "#sign_out" do
    it "should logout the current_user" do
      sign_in(user)
      sign_out
      current_user.should be_nil
    end
  end
end