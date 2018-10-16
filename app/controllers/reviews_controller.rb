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

  def destroy
    @review = Review.find(params[:id])
    user_id = @review.user_id
    @review.destroy
    redirect_to "/users/#{user_id}"
  end

end
