require 'rails_helper'

describe 'Book show' do

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

  it "Can display a book's show page" do
    visit '/books/1'

    expect(page).to have_current_path("/books/#{@book1.id}")
    expect(page).to have_content("Title 1")
    expect(page).to have_content("1.5 rating from 2 reader reviews")
    expect(page).to have_link("Leave a Review")
    expect(page).to have_content("Author 1, Author 2")
    expect(page).to have_content("2001")
    expect(page).to have_content("Pages: 100")
    expect(page).to have_content("Title: Review 1")
    expect(page).to have_content("Rating: 2")
    expect(page).to have_content("Description: Text 1")
  end

  it 'display top three and bottom three reviews in order' do
    visit '/books/1'

    card = page.all('.top_three').first
    card.should have_content("Review: Review 2")
    card.should have_content("Rating: 2")

    card = page.all('.top_three').last
    card.should have_content("Review: Review 1")
    card.should have_content("Rating: 1")
  end

  it 'display top three and bottom three reviews in order' do
    visit '/books/1'

    card = page.all('.bottom_three').first
    card.should have_content("Review: Review 1")
    card.should have_content("Rating: 1")

    card = page.all('.bottom_three').last
    card.should have_content("Review: Review 2")
    card.should have_content("Rating: 2")
  end
end
