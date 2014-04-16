class BlocksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update]


  def new
  	@block = Block.new(:user => current_user)
  end

  def create
  	@story = Story.find(params[:story_id])
  	@block = @story.blocks.create(block_params)
  	@block.user = current_user
  	@block.save
  	if @block.save
  		flash.now[:success] = "Block created!"
  		redirect_to @story
  	else
  		render 'new'
  	end
  end

  def edit
  	@block = Block.find(params[:id])
  	@story = Story.find(params[:story_id])
  end

  def update
  	@story = Story.find(params[:story_id])
  	@block = Block.find(params[:id])
  	if @block.update_attributes(block_params)
  		flash.now[:success] = "Block updated!"
  		redirect_to @story
  	else 
  		render 'edit'
  	end
  end

  def destroy
  	@story = Story.find(params[:story_id])
  	@block = Block.find(params[:id])
  	@block.destroy
  	redirect_to @story
  end

  private

  	def block_params
  		params.require(:block).permit(:content)
  	end
end