require 'spec_helper'

describe StoryController do

	describe "GET #new" do
		it "assigns a new Story to @story"
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "creates a new story" do
				expect{
					post :create, story: FactoryGirl.create(:story)
				}.to change(Story,:count).by(1)
			end

			it "redirects to the story show page" do
				post :create, story: FactoryGirl.create(:story)
				response.should redirect_to @story
			end
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
