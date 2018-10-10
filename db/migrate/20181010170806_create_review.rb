class CreateReview < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string    :title
      t.string    :description
      t.integer   :score
      t.reference :books, :review, foreign_keys: true 
      t.timestamps
    end
  end
end
