

class Book < ApplicationRecord

  validates_presence_of :title, :pages, :year #, :authors

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors


  # --- Creation ---

  def make_new_book(params)
    title = assess_title(params[:title])
    return title if title == duplicate_error
    book = Book.create(title: title, pages: params[:pages], year: params[:year])
    authors = assess_authors(params[:authors])
    # collection = authors.map { |name| find_an_author(name) }
    authors.each { |name| find_and_add_author(name, book) }
  end

  def assess_authors(csv)
    return [csv] if !csv.include?(',')
    csv.include?(", ") ? csv.split(", ") : csv.include?(",")
  end

  def find_and_add_author(name, book)
    name = name.titleize
    author = Author.find_by_name(name)
    author ? pair_with_author(author, book) : book.authors.create(name: name)
  end

  def pair_with_author(author, book)
    book.authors << author
    # IS THIS REDUNDANT ??
    author.books << book
  end

  def assess_title(title)
    title = title.titleize
    invalid = Book.find_by_title(title)
    invalid ? duplicate_error : title
  end

  def duplicate_error
    "ERROR - entry already exists."
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
  def self.sort_by_average_rating
    books = Book.all
    books.select(:books, :'average_rating AS av_score')
    .joins(:results)
    .order(:av_score)
  end






end
