require 'spec_helper'

describe Space do

  before(:each) do
    @space = Space.new(title: "Test Space", description: "Test description")
    @user = User.new(username: "Example User", email: "user@example.com",
  					 password: "foobar", password_confirmation: "foobar")
    @block = Block.new(content: "test")

  end

  subject { @space }

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
  	@space.blocks.size.should == 0
  end

  it "Should have no collaborators" do
  	@space.users.size.should == 0
  end

  it "Should have one collaborator" do
  	@space.users << @user
  	@space.users.size.should == 1
  end

  it "Should have one block" do
  	@space.blocks << @block
  	@space.blocks.size.should == 1
  	@space.blocks.first == @block
  end

  it "Should delete the block when it gets destroyed" do
  	@space.blocks << @block
  	blockarray = @space.blocks.to_a
  	@space.destroy;
  	expect(blockarray).not_to be_empty
  	blockarray.each do |newblock|
  		expect(Block.where(id: newblock.id)).to be_empty
  	end
  end
end