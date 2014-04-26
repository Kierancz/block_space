require 'spec_helper'

describe StoryController do

	describe "GET #new" do
		it "assigns a new Story to @story"
	end

	describe "GET #index" do
		it "renders the :index view" do
			get :index
			response.should render_template :index
		end
	end

	describe "POST #create" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			sign_in @user
			@story = FactoryGirl.build(:story)
			@story.user = @user.id 
			@story.save

			@story_attributes = FactoryGirl.attributes_for(:story, :user => @user)
		end

			it "creates a new story" do
				expect{
					post :create, story: FactoryGirl.attributes_for(:story)
				}.to change(Story, :count).by(1)
			end

			it "redirects to the story show page" do
				post :create, story: FactoryGirl.create(:story)
				response.should redirect_to @story
			end

		context "with invalid attributes" do
			it "does not save the new block" do
				expect{
					post :create, story: FactoryGirl.create(:invalid_story)
				}.to_not change(Story,:count) 
			end
		end
	end
end
