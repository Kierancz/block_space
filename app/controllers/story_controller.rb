class StoryController < ApplicationController
	
  def index
  	@stories = Story.all
    @newstory = Story.new
	  @user_stories = current_user.stories
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.create(story_params)
    if @story.save
      redirect_to @story
    else
      render 'new'
    end
  end

  def show
  	id = params[:id]
    @story = Story.find(id)
    @blocks = @story.blocks.all
    @users = @story.users.all
  end

  private

    def story_params
      params.require(:story).permit(:description, :title)
    end
end
