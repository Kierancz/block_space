class StoryController < ApplicationController
	
  def index
  	@stories = Story.all
	@user_stories = current_user.stories
  end

  def show
  	id = params[:id]
    @story = Story.find(id)
    @blocks = @story.blocks.all
    @users = @story.users.all
  end
end
