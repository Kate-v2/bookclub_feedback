class Author < ApplicationRecord
  validates_presence_of :name
  has_many :book_authors
  has_many :books, through: :book_authors
  has_many :reviews, through: :books


  def delete_author
    delete_books(self)
    self.destroy
  end

  def delete_books(author)
    author.books.each { |book|
      co_authors  = BookAuthor.where(book: book)
      only_author = co_authors.length == 1
      only_author ? no_other_authors(co_authors, book) : remaining_authors(co_authors, author)
     }
  end

  def no_other_authors(author, book)
    author.first.destroy
    book.remove_reviews(book.reviews)
    book.destroy
  end

  def remaining_authors(authors, author)
    authors.find_by_author_id(author.id).destroy
  end
end
