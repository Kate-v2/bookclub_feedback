require 'rails_helper'

describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :name}
  end

  describe 'Relationships' do
    it { should have_many(:reviews) }
  end

  describe 'Creation' do

    it 'can create a user' do
      user1 = User.create(name: "One")
      user2 = User.create(name: "Two")
      expect(User.all.count).to eq(2)
      expect(user1.name).to eq("One")
      expect(user2.name).to eq("Two")
    end
  end

end
