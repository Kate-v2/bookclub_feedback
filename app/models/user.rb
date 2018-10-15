
class User < ApplicationRecord

  validates_presence_of :name

  has_many :reviews

  def assess_params(params)
    if params[:sort] == 'oldest'
      sort_by_oldest
    elsif params[:sort] == 'newest'
      sort_by_newest
    else
      reviews.all
    end
  end


  # --- Deletion ---

  def delete_user
    delete_reviews(self)
    self.destroy
  end

  def delete_reviews(user)
    reviews = user.reviews
    reviews.each { |rev| rev.destroy }
  end


  # --- Sorting ---

  def sort_by_oldest
    reviews.order("created_at ASC")
  end

  def sort_by_newest
    reviews.order("created_at DESC")
  end


  # --- Exceptional ---

  def self.users_with_reviews
    select('users.*, count(users.id) AS review_count')
    .joins(:reviews)
    .group(:user_id, :id)
  end

  def self.top_reviewers
    users_with_reviews.order('review_count DESC').limit(3)
  end

end
