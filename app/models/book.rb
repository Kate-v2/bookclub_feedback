

class Book < ApplicationRecord

  validates_presence_of :pages, :year
  validates :title, presence: true, uniqueness: true

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors


  def self.assess_params(params)
    books = books_with_review_stats
    books = books.assess_sort(params[:sort]) if  params[:sort]
    books = books.alphabetically             if !params[:sort]
    return books
  end

  def self.assess_sort(value)
    return alphabetically          if value == "a_title"
    return alphabetically_reverse  if value == "z_title"
    return lowest_rating_first     if value == "low_rating"
    return highest_rating_first    if value == "high_rating"
    return lowest_count_first      if value == "low_count"
    return highest_count_first     if value == "high_count"
    return fewest_pages_first      if value == "low_pages"
    return most_pages_first        if value == "high_pages"
  end


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


  # --- Deletion ---

  def delete_book
    remove_authors(self)
    remove_reviews(self.reviews)
    self.destroy
  end

  def remove_authors(book)
    authors = book.authors
    authors.each { |author|
      BookAuthor.where(book: book, author: author ).first.destroy
      author.destroy if author.books.count == 0
     }
  end

  def remove_reviews(reviews)
    reviews.each { |review| review.delete }
  end


  # --- Math ---

  def self.books_with_review_stats
    select(
      'books.*,

      CASE WHEN count(reviews.score) = 0
      THEN 0
      ELSE avg(reviews.score) END AS average_score,

      count(reviews.score) AS review_count'
    )
    .left_outer_joins(:reviews)
    .group(:book_id, :id)
  end


  # --- Sorting ---

  def self.alphabetically
    order(:title)
  end

  def self.alphabetically_reverse
    order(title: :DESC)
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
    order(:pages)
  end

  def self.most_pages_first
    order(pages: :DESC)
  end


  # --- Execptional ---

  def self.top_books(qty = 3)
    # books_with_review_stats.reorder('average_score DESC')
    reorder('average_score DESC')
    .limit(3)
  end

  def self.worst_books(qty = 3)
    # books_with_review_stats.reorder('average_score')
    reorder('average_score')
    .limit(3)
  end

  def bottom_three_reviews
    reviews.order('score ASC')
    .limit(3)
  end

  def top_three_reviews
    reviews.order('score DESC')
    .limit(3)
  end

end
