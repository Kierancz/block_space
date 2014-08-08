class SpaceController < ApplicationController
  	
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
    if current_user && (current_user.spaces.includes(@space) || current_user.admin?)
      @blocks = @space.blocks
      @users = @space.users
    
      # If parameters has a user to add to the collaboration list
      if params.has_key?(:user)
        puts params[:user][:username]
        #try to find by username
        collaborator = User.where(username: params[:user][:username].downcase).take
        #if username is not found, try email
        if !collaborator
          collaborator = User.where(email: params[:user][:username].downcase).take
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
    if (current_user.spaces.includes(@space) || current_user.admin?) && (@space.users.count >= 1)
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
      flash[:success] = "Space successfully updated!"
    #else
     # render :action => 'edit'
    end
  end

  def destroy
    @space = Space.find(params[:id])
    if current_user && (@space.users.include?(current_user) || current_user.admin?)
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

  def favorite
    @space = Space.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @space
      redirect_to :back, notice: "You favorited #{@space.title}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@space)
      redirect_to :back, notice: "Unfavorited #{@space.title}"

    else  #type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened'
    end
  end

  private

    def space_params
      params.require(:space).permit(:description, :title)
    end
end
