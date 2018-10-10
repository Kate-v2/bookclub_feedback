require 'rails_helper'

describe 'author index' do
  it 'user can see all authors' do
    user1 = User.create(name: "User 1")
    book  = Book.create(title: "Title 1", pages: 100,  year: 2000 )
    book.reviews.create(title: "Review 1", description: "description 1", score: 3, user_id: user1.id)

    visit '/authors'
    save_and_open_page 
    expect(page).to have_content("All Songs")
    expect(page).to have_content(song_1.title)
    expect(page).to have_content("Plays: #{song_1.play_count}")
    expect(page).to have_content(song_2.title)
    expect(page).to have_content("Plays: #{song_2.play_count}")
  end
end
