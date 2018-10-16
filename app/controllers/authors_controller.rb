class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @review = @author.reviews.order("score DESC").first
  end

  def destroy
    author = Author.find(params[:id])
    author.delete_author
    redirect_to books_path
  end

end
