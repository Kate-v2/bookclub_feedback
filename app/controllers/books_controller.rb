

class BooksController < ApplicationController

  def index
    @books = Book.assess_params(params)
    @top3  = @books.top_books
    @low3  = @books.worst_books
    @top_revs = User.top_reviewers
  end

  def show
    collection = Book.books_with_review_stats
    @books = [collection.find(params[:id])]
    @reviews = @books[0].reviews
  end


  def new
    @book = Book.new
  end

  def create
    Book.make_new_book(allow_params)
    redirect_to books_path
  end

  def destroy
    book = Book.find(params[:id])
    book.delete_book
    redirect_to books_path
  end

  private

  def allow_params
    params.require(:book).permit(:title, :year, :pages, :authors)
  end


end
