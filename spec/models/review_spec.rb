require 'rails_helper'


describe Review, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :description}
    it { should validate_presence_of :score}
    it { should validate_presence_of :book_id}
    # it { should validate_presence_of :user_id}
  end

  describe 'Relationships' do
    it { should belong_to :book }
  end

  describe 'Creation' do

    it 'should create a review through a book' do
      book = Book.create(title: "Title 1", pages: 100,  year: 2000 )
      book.reviews.create(title: "Review 1", description: "description 1", score: 3)
      review = book.reviews.first
      expect(review.title).to eq("Review 1")
      expect(review.description).to eq("description 1")
      expect(review.score).to eq(3)
      expect(book.reviews.count).to eq(1)
    end

    it 'should create multiple reviews through a book' do
      book = Book.create(title: "Title 1", pages: 100,  year: 2000 )
      book.reviews.create(title: "Review 1", description: "description 1", score: 3)
      book.reviews.create(title: "Review 2", description: "description 2", score: 2)
      review1 = book.reviews.first
      review2 = book.reviews.last
      expect(review1.title).to eq("Review 1")
      expect(review2.title).to eq("Review 2")
      expect(book.reviews.count).to eq(2)
    end


  end

end
