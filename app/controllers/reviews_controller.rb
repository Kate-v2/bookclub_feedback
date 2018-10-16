class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book_id = params[:id]
  end

  def create
    params.permit!
    Review.create(params[:review])
    user = User.find(params[:review][:user_id])
    redirect_to user_path(user)
  end

  def destroy
    @review = Review.find(params[:id])
    user_id = @review.user_id
    @review.destroy
    redirect_to user_path( User.find(user_id) )
  end

end
