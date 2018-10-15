

class BooksController < ApplicationController

  def index
    @books = Book.assess_params(params)
    @top3  = @books.top_books
    @low3  = @books.worst_books
    @top_revs = User.top_reviewers
  end

  def show
    @book = Book.find(params[:id])
  end


  def new
    # form
  end

  def create
    # post method
  end


end
