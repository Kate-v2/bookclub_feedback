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
        card.should have_content("Author 1")
        card.should have_content("Author 2")
      end
    end

    # TO DO - when averaging method is set up
    it 'Rating is present' do
    end

    # TO DO - when counting method is set up
    it 'Review Count is present' do
    end


  end
end
