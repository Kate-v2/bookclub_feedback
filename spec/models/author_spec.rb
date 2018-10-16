require 'rails_helper'

describe Author, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:book_authors)}
    it { should have_many(:books).through(:book_authors) }
    it { should have_many(:reviews).through(:books) }
  end

  describe 'Deletion' do

    it 'should delete all books only by that author' do
      book1 = {title: "Title 1", pages: 100, year: 2001}
      book2 = {title: "Title 2", pages: 200, year: 2002}
      book1 = Book.create(book1)
      book2 = Book.create(book2)
      author1 = Author.create({name: "Author 1"})
      author2 = Author.create({name: "Author 2"})
      BookAuthor.create(book: book1, author: author1)
      BookAuthor.create(book: book2, author: author1)
      BookAuthor.create(book: book2, author: author2)
      user = User.create(name: "User 1")
      review = {title: "Review 1", description: "Text 1", score: 1, book_id: book1.id, user_id: user.id}
      review = Review.create(review)

      expect(author1.books.length).to eq(2)
      expect(author2.books.length).to eq(1)
      expect(Book.all.length).to eq(2)
      expect(Author.all.length).to eq(2)
      expect(Review.all.length).to eq(1)

      author1.delete_author
      expect(Book.all.length).to eq(1)
      expect(Author.all.length).to eq(1)
      expect(Review.all.length).to eq(0)
      expect(author1.books.length).to eq(2)
    end

  end



end
