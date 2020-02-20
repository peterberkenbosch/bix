require "spec_helper"

RSpec.describe Bix::Repos::User do
  context "#create" do
    it "creates a user" do
      user = subject.create(
        first_name: "Ryan",
        last_name: "Bigg",
        age: 32,
      )

      expect(user).to be_a(Bix::Entities::User)
      expect(user.id).not_to be_nil
      expect(user.first_name).to eq("Ryan")
      expect(user.last_name).to eq("Bigg")
      expect(user.created_at).not_to be_nil
      expect(user.updated_at).not_to be_nil
    end
  end

  context "#all" do
    before do
      subject.create(first_name: "Ryan", last_name: "Bigg", age: 32)
    end

    it "returns all users" do
      users = subject.all
      expect(users.count).to eq(1)
      expect(users.first).to be_a(Bix::Entities::User)
    end
  end
end
