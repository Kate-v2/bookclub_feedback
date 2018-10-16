require 'rails_helper'


describe Review, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :description}
    it { should validate_presence_of :score}
    it { should validate_presence_of :book_id}
    it { should validate_presence_of :user_id}
  end

  describe 'Relationships' do
    it { should belong_to :book }
    it { should belong_to :user }
  end

  describe 'Deletion' do

    it 'can delete a review' do
      book = {title: "Title 1", pages: 100, year: 2001}
      book = Book.create(book)
      user = User.create(name: "User 1")
      rev = {title: "Review 1", description: "Text 1", score: 1, user_id: user.id, book_id: book.id }
      review = Review.create(rev)
      rev_ct = Review.all.length
      expect(rev_ct).to eq(1)

      review.delete_review
      rev_ct = Review.all.length
      expect(rev_ct).to eq(0)

      ct = user.reviews.length
      expect(ct).to eq(0)
    end


  end

  describe 'Creation' do

    it 'should create a review through a book' do
      user1 = User.create(name: "User 1")
      book  = Book.create(title: "Title 1", pages: 100,  year: 2000 )
      book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
      review = book.reviews.first
      expect(review.title).to eq("Review 1")
      expect(review.description).to eq("description 1")
      expect(review.score).to eq(3)
      expect(book.reviews.count).to eq(1)
    end

    it 'should create multiple reviews through a book' do
      user1 = User.create(name: "User 1")
      book  = Book.create(title: "Title 1", pages: 100,  year: 2000 )
      book.reviews.create!(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
      book.reviews.create!(title: "Review 2", description: "description 2", score: 2, user_id: user1.id)
      review1 = book.reviews.first
      review2 = book.reviews.last
      expect(review1.title).to eq("Review 1")
      expect(review2.title).to eq("Review 2")
      expect(book.reviews.count).to eq(2)
    end

    it 'should create a review through a user' do
      user1 = User.create(name: "User 1")
      book  = Book.create(title: "Title 1", pages: 100,  year: 2000 )
      user1.reviews.create(title: "Review 1", description: "description 1", score: 3, book_id: book.id)
      review = user1.reviews.first
      expect(user1.reviews.count).to eq(1)
      expect(review.title).to eq("Review 1")
    end


  end

end
