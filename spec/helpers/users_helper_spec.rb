require 'spec_helper'

describe UsersHelper do
	describe '#gravatar_for' do
    it "returns the image tag for the specified user's gravtar image" do
      user = User.create(username: "John", email: 'johndoe@example.com', password: "foobar", password_confirmation: "foobar")
      expect(gravatar_for(user)).to eq('<img alt="John" class="gravatar" src="https://secure.gravatar.com/avatar/fd876f8cd6a58277fc664d47ea10ad19" />')
    end
  end
end
