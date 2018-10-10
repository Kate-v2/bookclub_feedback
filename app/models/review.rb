
class Review < ApplicationRecord

  validates_presence_of :title, :description, :score, :book_id

  belongs_to :book



end
