class StoryController < ApplicationController
	
  def index
  	@stories = Story.all
    @newstory = Story.new
	  @user_stories = current_user.stories
  end

  def edit
    id = params[:id]
    @story = Story.find(id)

    # Make sure user has permission to view this
    if current_user && current_user.stories.includes(@story)
      @blocks = @story.blocks.all
      @users = @story.users.all
    
      # If parameters has a user to add to the collaboration list
      if params.has_key?(:user)
        puts params[:user][:username]
        collaborator = User.where(username: params[:user][:username]).take

        if !collaborator
          flash.now[:error] = 'Error: Username \'' + params[:user][:username] + '\' does not exist'
        elsif @users.map(&:id).include? collaborator.id
          flash.now[:error] = 'Error: User \'' + params[:user][:username] + '\' is already a collaborator'
        else
          @story.users << collaborator
        end
      end
    end
  end

  def removecollaborator
    @story = Story.find(params[:id])

    # Make sure current user has permission to remove collaborators
    if current_user.stories.includes(@story)
      deleteuser = User.find(params[:contributor])
      if deleteuser
        @story.users.delete(deleteuser)
      end
      redirect_to [:edit, @story]
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(story_params)
      redirect_to @story
    else
      render :action => 'edit'
    end
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
