

class Book < ApplicationRecord

  validates_presence_of :title, :pages, :year

  has_many :reviews
  # -- These models don't exist yet --
  # has_many :authors, through: :book_authors

end
