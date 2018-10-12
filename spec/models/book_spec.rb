require 'rails_helper'


describe Book, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
  end

  describe 'Relationships' do
    it { should have_many :reviews }
    it { should have_many(:book_authors)}
    it { should have_many(:authors).through(:book_authors) }
  end

  before(:each) do
    @author1 = Author.create(name: "Author 1")
    @author2 = Author.create(name: "Author 2")

    @book1 = Book.create(title: "Title 1", year: 2001, pages: 100 )
    @book2 = Book.create(title: "Title 2", year: 2002, pages: 200 )

    @author1.books << @book1
    @author1.books << @book2

    @author2.books << @book1

    @user1 = User.create(name: "User 1")
    @user2 = User.create(name: "User 2")

    @review1 = Review.create(title: "Review 1", score: 1, description: "text 1", book_id: @book1.id, user_id: @user1.id)
    @review2 = Review.create(title: "Review 2", score: 2, description: "text 2", book_id: @book1.id, user_id: @user2.id)
    @review3 = Review.create(title: "Review 3", score: 3, description: "text 3", book_id: @book2.id, user_id: @user2.id)
  end

  describe 'Creation' do

    it 'should be able to create a book' do
      count = Book.all.count
      first = Book.all.first
      expect(first.title).to eq("Title 1")
      expect(first.year).to eq(2001)
      expect(first.pages).to eq(100)
      expect(count).to eq(2)
    end

    describe 'it should be able to make a new book from params' do

      describe 'Authors' do

        describe "Single Author" do

          it 'pairs with an existing author' do
            params = {}
            params[:title]   = "Title 3"
            params[:year]    = 2003
            params[:pages]   = 300
            params[:authors] = @author1.name
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)

            found = Book.find(book3.id)
            expect(found)
            expect(found.authors.first.name).to eq(@author1.name)
          end

          it 'pairs with a new author' do
            params = {}
            params[:title]   = "Title 3"
            params[:year]    = 2003
            params[:pages]   = 300
            params[:authors] = "Author 3"
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)

            found = Book.find(book3.id)
            expect(found)
            expect(found.authors.first.name).to eq(params[:authors])
          end

        end

        describe 'Multiple Authors' do
          
          it 'pairs with multiple existing authors' do
            params = {}
            params[:title]   = "Title 3"
            params[:year]    = 2003
            params[:pages]   = 300
            params[:authors] = "#{@author1.name},#{@author2.name}"
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)

            found = Book.find(book3.id)
            expect(found)
            expect(found.authors.first.name).to eq(@author1.name)
            expect(found.authors.last.name).to  eq(@author2.name)
          end

          it 'pairs with multiple new authors' do
            new1 = "Author 3"; new2 = "Author 4"
            params = {}
            params[:title]   = "Title 3"
            params[:year]    = 2003
            params[:pages]   = 300
            params[:authors] = new1 + ',' + new2
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)

            found = Book.find(book3.id)
            expect(found)
            expect(found.authors.first.name).to eq(new1)
            expect(found.authors.last.name).to  eq(new2)
          end

          it 'pairs with multiple mixed exising or new authors' do
            existing = @author1.name; new1 = "Author 3"
            params = {}
            params[:title]   = "Title 3"
            params[:year]    = 2003
            params[:pages]   = 300
            params[:authors] = existing + ',' + new1
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)

            found = Book.find(book3.id)
            expect(found)
            expect(found.authors.first.name).to eq(existing)
            expect(found.authors.last.name).to  eq(new1)
          end

          describe 'CSV functionality' do
            it 'pairs book & authors via comma & space separation' do
              existing = @author1.name; new1 = "Author 3"
              params = {}
              params[:title]   = "Title 3"
              params[:year]    = 2003
              params[:pages]   = 300
              params[:authors] = existing + ', ' + new1
              expect(params.count).to eq(4)

              book3 = Book.make_new_book(params)
              expect(book3)

              found = Book.find(book3.id)
              expect(found)
              expect(found.authors.first.name).to eq(existing)
              expect(found.authors.last.name).to  eq(new1)
            end
          end
        end

      end
    end
  end

  describe 'Math' do

    it 'can count all of the reviews for a book instance' do
      ct = @book1.count_ratings
      expect(ct).to eq(2)
    end

    it 'can average the ratings of a single book' do
      av = @book1.average_rating
      expected = 1.5
      expect(av).to eq(expected)
    end

    it 'can average all ratings' do
      books = Book.sort_by_average_rating
      # @book1.average_rating
      binding.pry
      # book = @book1.average_rating
    end

  end

end
