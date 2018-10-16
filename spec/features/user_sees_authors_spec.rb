require 'rails_helper'

describe 'author index' do
  it 'user can selected author' do
    user1 = User.create(name: "User 1")
    user2 = User.create(name: "User 2")
    author_1 = Author.create(name: "Author_1")
    book = author_1.books.create(title: "Title 1", pages: 100, year:2000)
    book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)
    book.reviews.create(title: "Review 2", description: "description 2", score: 4, user_id: user2.id)

    visit '/authors/1'

    expect(page).to have_content(author_1.name)
    expect(page).to have_content("Published Work: #{book.title}")
    expect(page).to have_content("Pages: #{book.pages}")
  end

  it 'user can see top rated view for authors book' do
    user1 = User.create(name: "User 1")
    user2 = User.create(name: "User 2")
    user3 = User.create(name: "User 3")
    author_1 = Author.create(name: "Author_1")
    book = Book.create(title: "Title 1", pages: 100, year:2000)
    BookAuthor.create(book: book, author: author_1)
    rev1 = Review.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id, book_id: book.id)
    rev2 = Review.create(title: "Review 3", description: "description 3", score: 4, user_id: user3.id, book_id: book.id)
    rev3 = Review.create(title: "Review 2", description: "description 2", score: 5, user_id: user2.id, book_id: book.id)

    visit '/authors/1'

    expect(page).to have_content(author_1.name)
    expect(page).to have_content("Great Review: #{rev3.title}")
    expect(page).to have_content("Rating: #{rev3.score}")
    expect(page).to have_content("User: #{user2.name}")
  end

  # To DO - add a test that looks for card and asserts that page author is not present
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

    visit '/authors/1'

    expect(page).to have_content("Co-author(s): Author_2 Author_3")
  end

  it 'has user links' do
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

    visit '/authors/1'

    click_link 'User 2'

    expect(page).to have_current_path('/users/2')
    expect(page).to have_content('User 2')
    expect(page).to have_content('Title: Review 2')
    expect(page).to have_content('Description: description 2')
    expect(page).to have_content('Score: 4')
  end

  it 'has author links' do
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

    visit '/authors/1'

    click_link 'Author_2'

    expect(page).to have_current_path('/authors/2')
    expect(page).to have_content('Author_2')
    expect(page).to have_content('Published Work: Title 1')
    expect(page).to have_content('Pages: 100')
    expect(page).to have_content('Author_1 Author_3')
    expect(page).to have_content('Rating: 4')
  end

  it 'has book links' do
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

    visit '/authors/1'

    click_link 'Title 1'

    expect(page).to have_current_path('/books/1')
    expect(page).to have_content('Title 1')
    expect(page).to have_content('3.5 rating from 2 reader reviews')
    expect(page).to have_content('Pages: 100')
    expect(page).to have_content('Author_1, Author_2, Author_3')
    expect(page).to have_content('Review: Review 2')
    expect(page).to have_content('Review: Review 1')
  end

  it 'can delete author' do
    book1 = Book.create(title: "Title 1", pages: 100, year:2000)
    author1 = Author.create(name: "Author 1")
    BookAuthor.create(book: book1, author: author1 )

    book2 = Book.create(title: "Title 2", pages: 200, year:2000)
    author2 = Author.create(name: "Author 2")
    BookAuthor.create(book: book2, author: author2 )

    visit books_path
    expect(page).to have_content("Author 1")
    expect(page).to have_content("Author 2")
    expect(page).to have_content("Title 1")
    expect(page).to have_content("Title 2")

    visit author_path(author1)

    expect(page).to have_content("Author 1")
    expect(page).not_to have_content("Author 2")
    expect(page).to have_content("Title 1")

    link = page.find("a", :text => "delete author")
    link.click

    expect(page).to have_current_path(books_path)
    expect(page).not_to have_content("Author 1")
    expect(page).to have_content("Author 2")
    expect(page).not_to have_content("Title 1")
    expect(page).to have_content("Title 2")
  end


end
