

class BooksController < ApplicationController

  def index
    @books = Book.assess_params(params)
    @top3  = @books.top_books
    @low3  = @books.worst_books
  end

  def show
    @book = Book.find(params[:id])
  end


  def new
    @book = Book.new
  end

  def create
    Book.make_new_book(allow_params)
    redirect_to '/books'
  end

  private

  def allow_params
    params.require(:book).permit(:title, :year, :pages, :authors)
  end


end
