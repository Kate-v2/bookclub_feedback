class BookAuthor < ApplicationRecord
  validates_presence_of :book_id, :author_id
  belongs_to :book
  belongs_to :author
end
