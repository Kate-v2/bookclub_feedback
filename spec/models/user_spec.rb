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

  describe 'Instance Methods' do
    it 'can sort review based on oldest' do
      user1 = User.create(name: "One")
      user2 = User.create(name: "Two")
      book = Book.create(title: "Title 1", pages: 100, year:2000)
      review1 = book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
      review3 = book.reviews.create(title: "Review 3", description: "description 3", score: 5, user_id: user2.id)
      sleep 1
      review2 = book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

      expect(user2.sort_by_oldest).to eq [review3, review2]
    end

    it 'can sort review based on newest' do
      user1 = User.create(name: "One")
      user2 = User.create(name: "Two")
      book = Book.create(title: "Title 1", pages: 100, year:2000)
      review1 = book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user2.id)
      sleep 1
      review3 = book.reviews.create(title: "Review 3", description: "description 3", score: 5, user_id: user2.id)
      sleep 1
      review2 = book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

      expect(user2.sort_by_newest).to eq [review2, review3, review1]
    end
  end

  describe 'Class Methods' do
    describe 'users_with_reviews' do
      it 'creates a temporary table of users and reviews with reviews count' do

        user1 = User.create(name: "One")
        user3 = User.create(name: "Three")
        user2 = User.create(name: "Two")
        book = Book.create(title: "Title 1", pages: 100, year:2000)
        book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user2.id)
        book.reviews.create(title: "Review 6", description: "description 6", score: 5, user_id: user2.id)
        book.reviews.create(title: "Review 3", description: "description 3", score: 5, user_id: user3.id)
        book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user3.id)
        book.reviews.create(title: "Review 5", description: "description 5", score: 4, user_id: user3.id)
        book.reviews.create(title: "Review 4", description: "description 4", score: 1, user_id: user1.id)

        top_users = User.top_reviewers
        expect(top_users).to eq [user3, user2, user1]
      end
    end
  end

end
