

class Book < ApplicationRecord

  validates_presence_of :title, :pages, :year

  # -- These models don't exist yet --
  has_many :reviews
  # has_many :authors, through: :book_authors



end
