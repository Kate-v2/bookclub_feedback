

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

  def count_ratings
    reviews.count
  end

  def average_rating
    reviews.average(:score).to_f.round(2)
  end


  # --- Filtering ---

  # To Do - Test Me
  def self.sort_by_title
    order(:title)
  end

  # This doesn't quite work yet
  def self.sort_by_average_rating(collection)
    books = collection.joins(:reviews)
    .group(:book_id, :id)
    .order('avg(reviews.score)')
  end






end
