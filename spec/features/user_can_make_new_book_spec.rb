require 'rails_helper'

describe 'form' do

  it 'Fields are present and usable' do

    visit '/books/new'

    find_field('Title').value
    fill_in('Title', with: 'Title 1')

    find_field('Pages').value
    fill_in('Pages', with: 100)

    find_field('Year').value
    fill_in('Year', with: 2018)

    find_field('Authors').value
    fill_in('Authors', with: "Author 1, Author 2")


    before = Book.all.count
    expect(before).to eq(0)
    click_button('Create Book')
    success = Book.all.count
    expect(success).to eq(1)
  end

end
