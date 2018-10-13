

class BooksController < ApplicationController

  def index
    @books = Book.assess_params(params)
  end
end
