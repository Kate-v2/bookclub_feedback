require 'rails_helper'


describe Book, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
  end

  describe 'Relationships' do
    # -- These models don't exist yet --
    it { should have_many :reviews }
    # it { should have_many(:authors).through(:book_authors) }
  end

  describe 'Creation' do

    it 'should be able to create a book' do
      book = Book.create(title: "Title 1", pages: 100, year: 2000)
      expect(Book.all.count).to eq(1)
      expect(book.title).to eq("Title 1")
      expect(book.pages).to eq(100)
      expect(book.year).to eq(2000)

    end

  end

end
