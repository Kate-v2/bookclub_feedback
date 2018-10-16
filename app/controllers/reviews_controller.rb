class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book_id = params[:id]
  end

  def create
    params.permit!
    Review.create(params[:review])
    redirect_to "/users/#{params[:review][:user_id]}"
  end

  # KT WIP
  def destroy
    # binding.pry
    @review = Review.find(params[:id])
    @review.delete_review
    redirect_to "/users/#{params[:review][:user_id]}"
  end

end
