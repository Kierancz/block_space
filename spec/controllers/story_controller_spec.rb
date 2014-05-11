require 'spec_helper'

describe StoryController do
	let(:user) { FactoryGirl.create(:user) }
	let(:story) {FactoryGirl.create(:story, user: @user)}

	before { sign_in user }

	describe "GET #index" do
		it "succeeds" do
			get 'index'
			response.should be_success
		end

		it "renders the index template" do
			get 'index'
			response.should render_template("story/index")
		end
	end

<<<<<<< Updated upstream

	describe "POST #create" do
		it "creates a new story" do
			user = FactoryGirl.create(:user)
			sign_in user

			story = Story.create(FactoryGirl.attributes_for(:story, user: @user))
			assert story.save
		end
	end
=======
>>>>>>> Stashed changes
end
