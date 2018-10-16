
class Review < ApplicationRecord

  validates_presence_of :title, :description, :score, :book_id, :user_id

  belongs_to :book
  belongs_to :user


  # --- Deletion ---

  # This can really just go in the controller
  def delete_review
    self.destroy
  end
  # need to verify that a user with no other reviews
  # does not have to be deleted

end
