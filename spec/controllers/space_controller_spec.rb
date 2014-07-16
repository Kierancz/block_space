require 'spec_helper'

describe SpaceController do
	let(:user) { FactoryGirl.create(:user) }
	let(:space) {FactoryGirl.create(:space, user: @user)}

	before { sign_in user }

	describe "GET #index" do
		it "succeeds" do
			get 'index'
			response.should be_success
		end

		it "renders the index template" do
			get 'index'
			response.should render_template("space/index")
		end
	end
end
