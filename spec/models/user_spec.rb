require 'spec_helper'

describe User do

	before do
  		@user = User.new(username: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  	end

  	subject { @user }

  	it { should respond_to(:username) }
  	it { should respond_to(:email) }
    it { should respond_to(:stories)}
    it { should respond_to(:blocks)}

    describe "when name is not present" do
      before { @user.username = " " }
      it { should_not be_valid }
    end

    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
end
