require 'rails_helper'


describe Book, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
  end

  describe 'Relationships' do
    # -- These models don't exist yet --
    # it { should have_many :reviews }
    # it { should have_many(:authors).through(:book_authors) }
  end

end
