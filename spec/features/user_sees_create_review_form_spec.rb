describe 'Reviews Create' do
  it 'user sees new review form' do
    book = Book.create(title: "Title 1", pages: 100, year:2000)

    visit '/books'
    click_link('Leave a Review')

    find_field('Title').value
    find_field('Description').value
    find_field('Score').value
    find_field('User').value
    find_button('Create Review')
  end

  it 'can submit a form and create post a new review' do
    user2 = User.create(name: "Two")
    book = Book.create(title: "Title 1", pages: 100, year:2000)

    visit '/books'

    click_link('Leave a Review')

    fill_in('Title', with: 'Review 4')
    fill_in('Description', with: 'description 4')
    fill_in('Score', with: '1')
    fill_in('User', with: '1')

    click_button('Create Review')

    expect(page).to have_current_path('/users/1')
    expect(page).to have_content('Title: Review 4')
    expect(page).to have_content('Description: description 4')
    expect(page).to have_content('Score: 1')
  end
end
