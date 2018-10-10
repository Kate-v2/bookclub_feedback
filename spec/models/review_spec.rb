require 'rails_helper'


describe Review, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :description}
    it { should validate_presence_of :score}
    it { should validate_presence_of :book_id}
    # it { should validate_presence_of :user_id}
  end

  describe 'Relationships' do
    it { should belong_to :book }
  end

end
