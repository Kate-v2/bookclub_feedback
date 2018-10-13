require 'rails_helper'

describe 'Book Index' do

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

    @review1 = Review.create(title: "Review 1", score: 1, description: "Text 1", book_id: @book1.id, user_id: @user1.id)
    @review2 = Review.create(title: "Review 2", score: 2, description: "Text 2", book_id: @book1.id, user_id: @user2.id)
    @review3 = Review.create(title: "Review 3", score: 3, description: "Text 3", book_id: @book2.id, user_id: @user2.id)
  end


  it 'Can see all book cards' do
      visit '/books'
      count = page.all('.book').count
      expect(count).to eq(2)
  end

  describe 'Attributes within a book card' do

    it 'Title is present' do
      visit '/books'
      card = page.all('.book').first
      card.should have_content("Title 1")
      card.should_not have_content("Title 2")
    end

    it 'Year is present' do
      visit '/books'
      card = page.all('.book').first
      card.should have_content("2001")
      card.should_not have_content("2002")
    end

    describe 'Author(s) present' do

      it 'single author' do
        visit '/books'
        card = page.all('.book').last
        card.should have_content("Author 1")
        card.should_not have_content("Author 2")
      end

      it 'multiple authors' do
        visit '/books'
        card = page.all('.book').first
        save_and_open_page
        card.should have_content("Author 1")
        card.should have_content("Author 2")
        card.should have_content("Author 1, Author 2")
      end
    end

    it 'Rating is present' do
      visit '/books'

      card1 = page.all('.book').first
      card1.should have_content("1.5 rating")
      card1.should_not have_content("3.0 rating")

      card2 = page.all('.book').last
      card2.should have_content("3.0 rating")
      card2.should_not have_content("1.5 rating")
    end

    it 'Review Count is present' do
      visit '/books'

      card1 = page.all('.book').first
      card1.should have_content("2 reader reviews")
      card1.should_not have_content("1 reader reviews")

      card2 = page.all('.book').last
      card2.should have_content("1 reader reviews")
      card2.should_not have_content("2 reader reviews")
    end

  end
end
