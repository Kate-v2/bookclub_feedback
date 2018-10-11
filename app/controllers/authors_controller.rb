class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @review = @author.reviews.order("score DESC").first
  end

end
