class SpaceController < ApplicationController
  #in_place_edit_for :space, :collaborator
	
  def index
  	@spaces = Space.all
    @newspace = Space.new
    if current_user
	     @user_spaces = current_user.spaces
    end
  end

  def edit
    id = params[:id]
    @space = Space.find(id)

    # Make sure user has permission to view this
    if current_user && current_user.spaces.includes(@space)
      @blocks = @space.blocks
      @users = @space.users
    
      # If parameters has a user to add to the collaboration list
      if params.has_key?(:user)
        puts params[:user][:username]

        collaborator = User.where(username: params[:user][:username]).take
        #if username is not found, try email
        if !collaborator
          collaborator = User.where(email: params[:user][:username]).take
        end
        #if username and email are not found, user doesn't exist
        if !collaborator
          flash.now[:danger] = 'Error: User \'' + params[:user][:username] + '\' does not exist'
        #check to see if collaborator has already been added
        elsif @users.map(&:id).include? collaborator.id
          flash.now[:danger] = 'Error: User \'' + params[:user][:username] + '\' is already a collaborator'
        #the user is added as collaborator
        else
          @space.users << collaborator
        end
      end
    end
  end

  def removecollaborator
    @space = Space.find(params[:id])

    # Make sure current user has permission to remove collaborators
    if current_user.spaces.includes(@space) && (@space.users.count > 1)
      deleteuser = User.find(params[:contributor])
      if deleteuser
        @space.users.delete(deleteuser)
      end
    else     #trying to delete the only contributer
      flash[:danger] = "A Space cannot have zero contributors."
    end
    redirect_to [:edit, @space]
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_attributes(space_params)
      redirect_to @space
      flash.nows[:success] = "Space successfully updated!"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @space = Space.find(params[:id])
    if current_user && @space.users.include?(current_user)
      if @space.destroy()
        flash[:success] = "Space \'" + @space.title + "\' has been deleted."
      else
        flash[:danger] = "Space failed to be deleted. Please try again later."
      end
    end
    redirect_to action: "index"
  end

  def new
    @space = Space.new
  end

  def create
    @space = current_user.spaces.create(space_params)
    if @space.save
      redirect_to @space
    else
      render 'new'
    end
  end

  def show
    id = params[:id]
    @space = Space.find(id)
    @users = @space.users
    @lastedited = @space.blocks.order("created_at").last
    if !@lastedited
      @lastedited = @space
    end
  end

  private

    def space_params
      params.require(:space).permit(:description, :title)
    end
end
