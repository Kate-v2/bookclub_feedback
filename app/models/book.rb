

class Book < ApplicationRecord

  validates_presence_of :title, :pages, :year #, :authors

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors


  # To Do - Test Me
  def self.sort_by_title
    order(:title)
  end


  def average_rating
    reviews.average(:score).to_f.round(2)
  end

  def self.sort_by_average_rating
    books = Book.all
    # books.select()
  end





end
