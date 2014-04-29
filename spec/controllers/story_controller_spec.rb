require 'spec_helper'

describe StoryController do
	describe "GET #index" do
		it "renders the index template" do
			get 'index'
			response.should be_success
		end
	end


	describe "POST #create" do
		it "creates a new story" do
			expect{
				post :create, story: FactoryGirl.create(:story)
			}.to change(Story, :count).by(1)
		end

		it "redirects to the story show page" do
			post :create, story: FactoryGirl.create(:story)
			response.should redirect_to @story
		end
	end
end
