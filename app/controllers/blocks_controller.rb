class BlocksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update]


  def new
    @story = Story.find(params[:story_id])
  	@block = Block.new(:user => current_user)
  end

  def create
    @story = Story.find(params[:story_id])
    @block = @story.blocks.create(block_params)
    @maxnum = @story.blocks.order('number').last.number
    @block.user = current_user

    # If block is not to be inserted, create block at end of the list
    if session[:insertblock]
      if session[:insertblock] == 0
        if @maxnum.blank?
          @block.number = 1
        else
          @block.number = @maxnum + 1
        end
      else #Otherwise :insertblock = number of the block to be inserted
        @block.number = session[:insertblock]
      end
    else
      if @maxnum.blank?
        @block.number = 1
      else
        @block.number = @maxnum
      end
    end
    session[:insertblock] = 0

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

  def insert
    @story = Story.find(params[:story_id])
    if current_user && @story.users.include?(current_user)
      @block = Block.find(params[:id])
      @block.number = @block.number + 1
      session[:insertblock] = @block.number
      @blocknum = @block.number


      @i = @blocknum + 1
      @story.blocks.order('number').each do |block|
        next if block.number < @blocknum
        block.update_attribute(:number, @i)
        @i = @i + 1
      end
    end
  end

  private

  	def block_params
  		params.require(:block).permit(:content)
  	end
end