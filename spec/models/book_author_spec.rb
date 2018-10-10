require 'rails_helper'

describe BookAuthor, type: :model do
  describe "relationships" do
    it {should belong_to(:book)}
    it {should belong_to(:author)}
  end

  describe 'Validations' do
    it { should validate_presence_of(:book_id) }
    it { should validate_presence_of(:author_id) }
  end
end
