class BlocksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
  	@story = Story.find(params[:story_id])
  	@block = @story.blocks.create(block_params)
  	# @block.user = current_user
  	flash[:success] = "Block created!"
  	redirect_to @story
  end

  def destroy
  	@story = Story.find(params[:story_id])
  	@block = @story.blocks.find(params[:id])
  	@block.destroy
  	redirect_to @story
  end

  private

  	def block_params
  		params.require(:block).permit(:user_id, :content)
  	end
end