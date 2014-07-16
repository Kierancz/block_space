class StoryController < ApplicationController
  #in_place_edit_for :story, :collaborator
	
  def index
  	@stories = Story.all
    @newstory = Story.new
    if current_user
	     @user_stories = current_user.stories
    end
  end

  def edit
    id = params[:id]
    @story = Story.find(id)

    # Make sure user has permission to view this
    if current_user && current_user.stories.includes(@story)
      @blocks = @story.blocks
      @users = @story.users
    
      # If parameters has a user to add to the collaboration list
      if params.has_key?(:user)
        puts params[:user][:username]
        collaborator = User.where(username: params[:user][:username]).take

        if !collaborator
          flash.now[:danger] = 'Error: Username \'' + params[:user][:username] + '\' does not exist'
        elsif @users.map(&:id).include? collaborator.id
          flash.now[:danger] = 'Error: User \'' + params[:user][:username] + '\' is already a collaborator'
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
      flash[:success] = "Space successfully updated!"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @story = Story.find(params[:id])
    if current_user && @story.users.include?(current_user)
      if @story.destroy()
        flash[:success] = "Space \'" + @story.title + "\' has been deleted."
      else
        flash[:danger] = "Space failed to be deleted. Please try again later."
      end
    end
    redirect_to action: "index"
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
    @users = @story.users
    @lastedited = @story.blocks.order("created_at").last
    if !@lastedited
      @lastedited = @story
    end
  end

  private

    def story_params
      params.require(:story).permit(:description, :title)
    end
end
