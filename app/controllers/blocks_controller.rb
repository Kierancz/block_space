class BlocksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update]


  def new
  	@block = Block.new(:user => current_user)
  end

  def create
  	@story = Story.find(params[:story_id])
    @maxnum = @story.blocks.order('number').last.number
  	@block = @story.blocks.create(block_params)
  	@block.user = current_user
    @block.number = @maxnum + 1
  	@block.save
  	if @block.save
  		flash.now[:success] = "Block created!"
  		redirect_to @story
  	else
  		render 'new'
  	end
  end

  def edit
    @story = Story.find(params[:story_id]) rescue nil
    if @story && current_user && @story.users.include?(current_user)
  	   @block = Block.find(params[:id])
    else
      redirect_to controller: "story", action: "index"
    end
  end

  def update
    @story = Story.find(params[:story_id])
    if @story && current_user && @story.users.include?(current_user)
     @block = Block.find(params[:id])
     if @block.update_attributes(block_params)
      flash.now[:success] = "Block updated!"
      redirect_to @story
    else 
      render 'edit'
    end
  else
    redirect_to controller: "story", action: "index"
  end
end

  def destroy
    @story = Story.find(params[:story_id])
    if current_user && @story.users.include?(current_user)
     @block = Block.find(params[:id])
     @block.destroy

     @i = 1
     @story.blocks.order('number').each do |block|
        block.update_attribute(:number, @i)
        @i = @i + 1
      end
     redirect_to @story
   end
  end

  private

  	def block_params
  		params.require(:block).permit(:content)
  	end
end