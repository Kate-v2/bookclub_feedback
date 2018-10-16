
class Review < ApplicationRecord

  validates_presence_of :title, :description, :score, :book_id, :user_id

  belongs_to :book
  belongs_to :user


  # --- Deletion ---

  def delete_review
    self.destroy
  end

end
