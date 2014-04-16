require 'spec_helper'

describe Story do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @story = Story.new(title: "Test Story", description: "Test description")
  end

  subject { @story }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
end