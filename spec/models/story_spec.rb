require 'spec_helper'

describe Story do

  before(:each) do
    @story = Story.new(title: "Test Story", description: "Test description")
    @user = User.new(username: "Example User", email: "user@example.com",
  					 password: "foobar", password_confirmation: "foobar")
    @block = Block.new(content: "test")

  end

  subject { @story }

  it { should be_valid}
  it { should respond_to(:id) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:created_at) }
  it { should respond_to(:users) }
  it { should respond_to(:blocks) }
  it { should_not respond_to(:hello) }

  it "Should have no blocks" do
  	@story.blocks.size.should == 0
  end

  it "Should have no collaborators" do
  	@story.users.size.should == 0
  end

  it "Should have one collaborator" do
  	@story.users << @user
  	@story.users.size.should == 1
  end

  it "Should have one block" do
  	@story.blocks << @block
  	@story.blocks.size.should == 1
  	@story.blocks.first == @block
  end

  it "Should delete the block when it gets destoryed" do
  	@story.blocks << @block
  	blockarray = @story.blocks.to_a
  	@story.destroy;
  	expect(blockarray).not_to be_empty
  	blockarray.each do |newblock|
  		expect(Block.where(id: newblock.id)).to be_empty
  	end
  end
end