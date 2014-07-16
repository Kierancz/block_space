class BlocksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new, :edit, :update]

  def new
    @space = Space.find(params[:space_id])
  	@block = Block.new(:user => current_user)
  end

  def create
    @space = Space.find(params[:space_id])
    @block = @space.blocks.create(block_params)
    @maxnum = @space.blocks.length - 1
    @block.user = current_user

    if session[:insertblock]
      # If block is not to be inserted, create block at end of the list
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
      redirect_to @space
    else
      render 'new'
    end
  end

  def edit
    @space = Space.find(params[:space_id]) rescue nil
    if @space && current_user && @space.users.include?(current_user)
  	   @block = Block.find(params[:id])
    else
      redirect_to controller: "space", action: "index"
    end
  end

  def update
    @space = Space.find(params[:space_id])
    if @space && current_user && @space.users.include?(current_user)
      @block = Block.find(params[:id])
      if @block.update_attributes(block_params)
        flash.now[:success] = "Block updated!"
        redirect_to @space
      else 
        render 'edit'
      end
    else
      redirect_to controller: "space", action: "index"
    end
  end

  def destroy
    @space = Space.find(params[:space_id])
    if current_user && @space.users.include?(current_user)
     @block = Block.find(params[:id])
     @block.destroy

     @i = 1
     @space.blocks.order('number').each do |block|
        block.update_attribute(:number, @i)
        @i = @i + 1
      end
     redirect_to @space
   end
  end

  def insert
    @space = Space.find(params[:space_id])
    if current_user && @space.users.include?(current_user)
      @block = Block.find(params[:id])
      @block.number = @block.number + 1
      session[:insertblock] = @block.number
      @blocknum = @block.number


      @i = @blocknum + 1
      @space.blocks.order('number').each do |block|
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