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

    @quick_book   = {title: "Title 3", year: 2003, pages: 300}
    @quick_review = {title: "Review 4", score: 4, description: "text 4"}
    @quick_user   = {name: "User 3"}
  end

  it 'Can see all book cards' do
    visit '/books'
    
    count = page.all('.book').count
    expect(count).to eq(2)
  end

  it 'Can link to and add a new book' do
    visit '/books'
    click_link('New Book')
    page.should have_current_path('/books/new')
  end

  it "Can link to each author's show page" do
    visit '/books'
    card = page.all('.book').first
    link = card.all('.author-link').first
    link.click
    expect(page).to have_current_path("/authors/#{@author1.id}")
  end

  it "Can link to each book's show page" do
    visit '/books'
    card = page.all('.book').first
    link = card.all('.book-link').first
    link.click
    expect(page).to have_current_path("/books/#{@book1.id}")
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



  describe 'User can see & use sort dropdown' do

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

    it 'can access the dropdown menu' do
      visit '/books'

      button = page.first('.sort-button')
      button.should have_content("Sort By")

      found = page.all('.sort-dropdown')
      ct = found.count
      expect(ct).to eq(1)

      drop = found.first

      drop.should have_content("Title: A-Z")
      drop.should have_content("Title: Z-A")
      drop.should have_content("Highest Rated")
      drop.should have_content("Lowest Rated")
      drop.should have_content("Most Rated")
      drop.should have_content("Least Rated")
      drop.should have_content("Most Pages")
      drop.should have_content("Least Pages")
    end

    it 'default sort - Title A-Z' do
      visit '/books'
      books = page.all('.book')
      first = books.first
      last  = books.last
      first.should have_content("Title 1")
      last.should  have_content("Title 3")
    end

    describe 'Sort Title' do

      it 'Ascending' do
        visit "/books"
        click_link('Title: A-Z')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 1")
        last.should  have_content("Title 3")
      end

      it 'Descending' do
        visit "/books"
        click_link('Title: Z-A')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 3")
        last.should  have_content("Title 1")
      end
    end

    describe 'Sort Rating' do

      it 'Ascending' do
        visit "/books"
        click_link('Lowest Rated')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 3")
        last.should  have_content("Title 2")
      end

      it 'Descending' do
        visit "/books"
        click_link('Highest Rated')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 2")
        last.should  have_content("Title 3")
      end
    end

    describe 'Sort Review Count' do

      it 'Ascending' do
        visit "/books"
        click_link('Least Rated')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 2")
        last.should  have_content("Title 3")
      end

      it 'Descending' do
        visit "/books"
        click_link('Most Rated')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 3")
        last.should  have_content("Title 2")
      end
    end

    describe 'Sort Page Count' do

      it 'Ascending' do
        visit "/books"
        click_link('Least Pages')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 1")
        last.should  have_content("Title 3")
      end

      it 'Descending' do
        visit "/books"
        click_link('Most Pages')
        books = page.all('.book')
        first = books.first
        last  = books.last
        first.should have_content("Title 3")
        last.should  have_content("Title 1")
      end
    end
  end

  describe 'Book Stats' do

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

    it 'Top 3 Books as Links' do
      visit "/books"
      stats = page.find('#book-stats')
      top   = stats.find('#top-books')
      three = top.all('a')

      ct = three.count
      expect(ct).to eq(3)
      three[0].should have_content('Title 2')
      three[1].should have_content('Title 1')
      three[2].should have_content('Title 3')

      three[0].click
      expect(page).to have_current_path "/books/2"

      three[1].click
      expect(page).to have_current_path "/books/1"

      three[2].click
      expect(page).to have_current_path "/books/3"
    end

    it 'Worst 3 Books as Links' do
      visit "/books"
      stats = page.find('#book-stats')
      worst   = stats.find('#worst-books')
      three = worst.all('a')

      ct = three.length
      expect(ct).to eq(3)
      three[0].should have_content('Title 3')
      three[1].should have_content('Title 1')
      three[2].should have_content('Title 2')

      three[0].click
      expect(page).to have_current_path "/books/3"

      three[1].click
      expect(page).to have_current_path "/books/1"

      three[2].click
      expect(page).to have_current_path "/books/2"
    end

    it 'Stats does not affect contents of book collection' do
      visit '/books'
      books = page.all('.book')
      first = books.first
      last  = books.last
      first.should have_content("Title 1")
      last.should  have_content("Title 3")
    end


  end

end

def open_page
  save_and_open_page
end

def open_pry
  save_and_open_page
end
