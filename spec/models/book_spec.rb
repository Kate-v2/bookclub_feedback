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

    @quick_book   = {title: "Title 3", year: 2003, pages: 300}
    @quick_review = {title: "Review 4", score: 4, description: "text 4"}
    @quick_user   = {name: "User 3"}
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

      describe "Title" do

        it 'should Title-Case the title' do
          params = @quick_book
          params[:title]   = "the test title"
          params[:authors] = @author1.name
          expect(params.count).to eq(4)

          book3 = Book.make_new_book(params)
          expect(book3)
          found = Book.find(book3.id)
          expect(found)
          expect(Book.all.count).to eq(3)

          expect(found.title).to     eq("The Test Title")
          expect(found.title).to_not eq(params[:title])
        end

      end

      describe 'Authors' do

        describe 'should Title-Case the name(s)' do

          it 'single name' do
            params = @quick_book
            params[:authors] = "single name"
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to     eq("Single Name")
            expect(found.authors.first.name).to_not eq(params[:authors])
          end

          it 'multiple names' do
            new1 = "more than"; new2 = "one name"
            params = @quick_book
            params[:authors] = new1 + "," + new2
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to     eq("More Than")
            expect(found.authors.first.name).to_not eq(new1)
            expect(found.authors.last.name).to      eq("One Name")
            expect(found.authors.last.name).to_not  eq(new2)
          end
        end

        describe "Single Author" do

          it 'pairs with an existing author' do
            params = @quick_book
            params[:authors] = @author1.name
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to eq(@author1.name)
          end

          it 'pairs with a new author' do
            params = @quick_book
            params[:authors] = "Author 3"
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to eq(params[:authors])
          end

        end

        describe 'Multiple Authors' do

          it 'pairs with multiple existing authors' do
            params = @quick_book
            params[:authors] = "#{@author1.name},#{@author2.name}"
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to eq(@author1.name)
            expect(found.authors.last.name).to  eq(@author2.name)
          end

          it 'pairs with multiple new authors' do
            new1 = "Author 3"; new2 = "Author 4"
            params = @quick_book
            params[:authors] = new1 + ',' + new2
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to eq(new1)
            expect(found.authors.last.name).to  eq(new2)
          end

          it 'pairs with multiple mixed existing or new authors' do
            existing = @author1.name; new1 = "Author 3"
            params = @quick_book
            params[:authors] = existing + ',' + new1
            expect(params.count).to eq(4)

            book3 = Book.make_new_book(params)
            expect(book3)
            found = Book.find(book3.id)
            expect(found)
            expect(Book.all.count).to eq(3)

            expect(found.authors.first.name).to eq(existing)
            expect(found.authors.last.name).to  eq(new1)
          end

          describe 'CSV functionality' do
            it 'pairs book & authors via comma & space separation' do
              existing = @author1.name; new1 = "Author 3"
              params = @quick_book
              params[:authors] = existing + ', ' + new1
              expect(params.count).to eq(4)

              book3 = Book.make_new_book(params)
              expect(book3)
              found = Book.find(book3.id)
              expect(found)
              expect(Book.all.count).to eq(3)

              expect(found.authors.first.name).to eq(existing)
              expect(found.authors.last.name).to  eq(new1)
            end
          end
        end

      end
    end
  end

  describe 'Math' do

    # it 'can count all of the reviews for a book instance' do
    #   ct = @book1.count_ratings
    #   expect(ct).to eq(2)
    # end
    #
    # it 'can average the ratings of a single book' do
    #   av = @book1.average_rating
    #   expected = 1.5
    #   expect(av).to eq(expected)
    # end

    # it 'can average all ratings' do
    #   books = Book.sort_by_average_rating
    #   # @book1.average_rating
    #   # binding.pry
    #   # book = @book1.average_rating
    # end

  end

  describe 'Sorting' do

    before(:each) do
      @book3 = Book.create!(@quick_book) #doesn't need an author to instantiate
      @user3 = User.create(@quick_user)

      params = @quick_review
      params[:score] = 1
      params[:book_id] = @book3.id
      params[:user_id] = @user3.id
      review3 = Review.create(params)
      review4 = Review.create(params)
      review5 = Review.create(params)

      @books = Book.books_with_review_stats
    end

    it 'has a known starting order' do
      expect(@books.length).to eq(3)
      expect(@books[0].title).to eq("Title 1")
      expect(@books[1].title).to eq("Title 3")
      expect(@books[2].title).to eq("Title 2")
      # tables via .joins reorders results in unexpected order
    end

    describe 'Title' do
      it 'Ascending' do
        first, *, last = @books.sort_by_title
        expect(first.title).to eq("Title 1")
        expect(last.title).to  eq("Title 3")
      end
    end

    describe 'Review Stats' do
      describe 'Average Rating' do

        it 'Ascending' do
          first = @books[0].title
          expect(first).to eq("Title 1")

          sorted = @books.lowest_rating_first
          first, *, last = sorted
          first_score = first.average_score.to_f
          last_score  =  last.average_score.to_f

          expect(first.title).to eq("Title 3")
          expect(last.title).to  eq("Title 2")
          expect(first_score).to eq(1.0)
          expect(last_score).to  eq(3.0)
        end

        it 'Descending' do
          first = @books[0].title
          expect(first).to eq("Title 1")

          sorted = @books.highest_rating_first
          first, *, last = sorted
          first_score = first.average_score.to_f
          last_score  =  last.average_score.to_f

          expect(first.title).to eq("Title 2")
          expect(last.title).to  eq("Title 3")
          expect(first_score).to eq(3.0)
          expect(last_score).to  eq(1.0)
        end
      end

      describe 'Number of Reviews' do

        it 'Ascending' do
          first = @books[0].title
          expect(first).to eq("Title 1")

          sorted = @books.lowest_count_first
          first, *, last = sorted
          first_count = first.review_count
          last_count  =  last.review_count

          expect(first.title).to eq("Title 2")
          expect(last.title).to  eq("Title 3")
          expect(first_count).to eq(1)
          expect(last_count).to  eq(3)
        end

        it 'Descending' do
          first = @books[0].title
          expect(first).to eq("Title 1")

          sorted = @books.highest_count_first
          first, *, last = sorted
          first_count = first.review_count
          last_count  =  last.review_count

          expect(first.title).to eq("Title 3")
          expect(last.title).to  eq("Title 2")
          expect(first_count).to eq(3)
          expect(last_count).to  eq(1)
        end
      end
    end

    describe 'Page Count' do

      it 'Ascending' do
        books = Book.books_with_review_stats
        expect(books.first.title).to eq("Title 1")

        first, *, last = books



      end


    end


  end



end
