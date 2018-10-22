require 'rails_helper'

describe 'form' do

  it 'has title' do
    visit new_book_path
    title = page.all('h1')
    expect(title.count).to eq(1)
    expect(title.first).to have_content('Add a Book!')
  end

  it 'has return to all books link' do
    visit new_book_path
    link = page.find('a', text: "Home")
    link.click
    expect(page).to have_current_path(books_path)
  end



  it 'Fields are present and usable' do
    visit new_book_path

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

    page.should have_current_path(books_path)
    page.should have_content("Title 1")
    page.should have_content("0.0 rating")
    page.should have_content("0 reader")

  end

end
