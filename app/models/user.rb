
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

  def sort_by_oldest
    reviews.order("created_at ASC")
  end

  def sort_by_newest
    reviews.order("created_at DESC")
  end
end
