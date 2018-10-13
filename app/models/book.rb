

class Book < ApplicationRecord

  validates_presence_of :pages, :year
  validates :title, presence: true, uniqueness: true

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors


  # --- Creation ---

  def self.make_new_book(params)
    title   = params[:title].titleize
    pages   = params[:pages]
    year    = params[:year]
    authors = params[:authors]
    book = Book.create(title: title, pages: pages, year: year)
    manage_authors(authors, book)
    return book
  end

  def self.manage_authors(csv, book)
    authors = assess_authors(csv)
    authors.each { |name| find_and_add_author(name, book) }
  end

  # Can't handle mixed type CSV
  def self.assess_authors(csv)
    case1 = ","; case2 = ", "
    return [csv] if !csv.include?(case1)
    csv.include?(case2) ? csv.split(case2) : csv.split(case1)
  end

  def self.find_and_add_author(name, book)
    name = name.titleize
    author = Author.find_or_create_by(name: name)
    pair_with_author(author, book)
  end

  def self.pair_with_author(author, book)
    BookAuthor.create(book: book, author: author)
  end


  # --- Math ---

  # Get rid of these methods.
  # By default, the controller should
  # create the temp 'with ratings' table
  # and then instead of looking at the
  # the whole database every time to do
  # these calculations, it can quickly
  # just find this column of the book row
  # def count_ratings
  #   reviews.count
  # end
  #
  # def average_rating
  #   reviews.average(:score).to_f.round(2)
  # end


  # --- Sorting ---

  def self.sort_by_title
    order(:title)
  end

  # TO DO - TEST ME specifically -- sufficiently proven via sorts though
  def self.books_with_review_stats
    select('books.*, avg(reviews.score) AS average_score, count(reviews.score) AS review_count')
    .joins(:reviews)
    .group(:book_id, :id)
  end

  def self.lowest_rating_first
    order('average_score')
  end

  def self.highest_rating_first
    order('average_score DESC')
  end

  def self.lowest_count_first
    order('review_count')
  end

  def self.highest_count_first
    order('review_count DESC')
  end

  def self.fewest_pages_first
    order('pages')
  end

  def self.most_pages_first
    order('pages DESC')
  end



end
