require 'spec_helper'

describe Block do

   before(:each) do
    @space = Space.new(title: "Test Space", description: "Test description")
    @user = User.new(username: "Example User", email: "user@example.com",
  					 password: "foobar", password_confirmation: "foobar")
    @block = Block.new(content: "test", space_id: 2)

  end

  subject { @block }

  it { should be_valid}
  it { should respond_to(:id) }
  it { should respond_to(:content) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:created_at) }

end
