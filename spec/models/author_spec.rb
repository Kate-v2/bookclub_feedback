require 'rails_helper'

describe Author, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it {should have_many(:book_authors)}
    it { should have_many(:books).through(:book_authors) }
  end

  describe "Class Methods" do
    it "should find one of the highest rated reviews" do
      author_1 = Author.create(name: "Author_1")
      book = author_1.books.create(title: "Title 1", pages: 100, year:2000)
      user1 = User.create(name: "User 1")
      user2 = User.create(name: "User 2")
      book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
      book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)


      great_review = author_1.great_review
      expect(great_review.title).to eq "Review 2"
      expect(great_review.score).to eq 4
    end
  end
end
