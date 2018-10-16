require 'rails_helper'

describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :name}
  end

  describe 'Relationships' do
    it { should have_many(:reviews) }
  end

  describe 'Deletion' do

    it 'should delete all reviews by a user and the user' do
      book1 = {title: "Title 1", pages: 100, year: 2001}
      book2 = {title: "Title 2", pages: 200, year: 2002}
      book3 = {title: "Title 3", pages: 300, year: 2003}
      book_1 = Book.create(book1)
      book_2 = Book.create(book2)
      book_3 = Book.create(book3)

      user = User.create!(name: "User 1")
      rev1 = {title: "Review 1", description: "Text 1", score: 1, book_id: book_1.id, user_id: user.id}
      rev2 = {title: "Review 2", description: "Text 2", score: 2, book_id: book_2.id, user_id: user.id}
      rev3 = {title: "Review 3", description: "Text 3", score: 3, book_id: book_3.id, user_id: user.id}
      user.reviews.create(rev1)
      user.reviews.create(rev2)
      user.reviews.create(rev3)

      users = User.all.length
      expect(users).to eq(1)
      reviews = Review.all.length
      expect(reviews).to eq(3)

      user.delete_user
      users = User.all.length
      expect(users).to eq(0)
      reviews = Review.all.length
      expect(reviews).to eq(0)
    end
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
