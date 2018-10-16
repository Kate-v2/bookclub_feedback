require 'rails_helper'

describe 'user sees selected users reviews' do
  it 'shows co authors as well' do
    user1 = User.create(name: "User 1")
    user2 = User.create(name: "User 2")
    author_1 = Author.create(name: "Author_1")
    author_2 = Author.create(name: "Author_2")
    author_3 = Author.create(name: "Author_3")
    book = Book.create(title: "Title 1", pages: 100, year:2000)
    BookAuthor.create(book: book, author: author_1 )
    BookAuthor.create(book: book, author: author_2 )
    BookAuthor.create(book: book, author: author_3 )
    review1 = book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
    review2 = book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

    visit '/users/2'

    expect(page).to have_content("User 2")
    expect(page).to have_content("Title: #{review2.title}")
    expect(page).to have_content("#{review2.description}")
    expect(page).to have_content("Score: #{review2.score}")
  end

  it 'can sort review based on oldest' do
    user2 = User.create(name: "Two")
    book = Book.create(title: "Title 1", pages: 100, year:2000)
    review1 = book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user2.id)
    sleep 1
    review3 = book.reviews.create(title: "Review 3", description: "description 3", score: 5, user_id: user2.id)
    sleep 1
    review2 = book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

    visit '/users/1'
    click_link('Oldest')

    review_card1 = page.all('.users').first
    review_card2 = page.all('.users').last
    review_card1.should have_content("Title: Review 1")
    review_card1.should have_content("Score: 3")
    review_card2.should have_content("Title: Review 2")
    review_card2.should have_content("Score: 4")
  end

  it 'can sort review based on newest' do
    user2 = User.create(name: "Two")
    book = Book.create(title: "Title 1", pages: 100, year:2000)
    review1 = book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user2.id)
    sleep 1
    review3 = book.reviews.create(title: "Review 3", description: "description 3", score: 5, user_id: user2.id)
    sleep 1
    review2 = book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

    visit '/users/1'

    click_link('Newest')

    review_card1 = page.all('.users').first
    review_card2 = page.all('.users').last
    review_card1.should have_content("Title: Review 2")
    review_card1.should have_content("Score: 4")
    review_card2.should have_content("Title: Review 1")
    review_card2.should have_content("Score: 3")
  end

  it 'can delete a review from the user page' do

    user = User.create(name: "User 1")
    book1 = {title: "Title 1", pages: 100, year: 2001}
    book2 = {title: "Title 2", pages: 200, year: 2002}
    book3 = {title: "Title 3", pages: 300, year: 2003}
    book1 = Book.create(book1)
    book2 = Book.create(book2)
    book3 = Book.create(book3)
    rev1 = {title: "Review 1", description: "Text 1", score: 1, user_id: user.id, book_id: book1.id}
    rev2 = {title: "Review 2", description: "Text 2", score: 2, user_id: user.id, book_id: book2.id}
    rev3 = {title: "Review 3", description: "Text 3", score: 3, user_id: user.id, book_id: book3.id}
    rev1 = Review.create(rev1)
    rev2 = Review.create(rev2)
    rev3 = Review.create(rev3)

    visit "/users/#{user.id}"
    reviews = page.all('.users')
    review = reviews.first
    expect(review).to have_content("Review 1")
    link = review.all('a').last
    link.click
    expect(page).to have_current_path("/users/#{user.id}")
    expect(page).not_to have_content("Review 1")
  end

end
