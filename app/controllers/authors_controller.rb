class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @review = Author.great_review
    binding.pry
  end

end
