

class BooksController < ApplicationController

  def index
    @books = Book.assess_params(params)
    @top3  = @books.highest_rating_first.limit(3)
    @low3  = @books.lowest_rating_first.limit(3)
    # @users = @users.most_reviews_first.limit(3)
  end

  def show
    @book = Book.find(params[:id])
  end


  def new

  end


end
