require 'spec_helper'

describe BlocksController do
	describe "GET #new" do
		it "assigns a new Block to @block"
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "creates a new block" do
				expect{
					post :create, block: FactoryGirl.create(:block)
				}.to change(Block,:count).by(1)
			end

			it "redirects to the story show page" do
				post :create, block: FactoryGirl.create(:block)
				response.should redirect_to @story
			end
		end

		context "with invalid attributes" do
			it "does not save the new block" do
				expect{
					post :create, block: FactoryGirl.create(:invalid_block)
				}.to_not change(Block,:count) 
			end
		end
	end
end
