require 'spec_helper'

describe SpaceController do
	let(:user) { FactoryGirl.create(:user) }
	let(:space) { FactoryGirl.create(:space, user: @user)	}


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

	describe "GET #show" do

		it "renders the show template" do
			get :show, id: space.id
			response.should render_template :show
		end
	end	
end
