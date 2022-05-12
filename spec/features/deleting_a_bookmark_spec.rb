feature 'deleting a bookmarks' do
  scenario 'user can delete a bookmark' do
    Bookmark.create(url: 'https://github.com', title: 'Github')

    visit('/bookmarks')

    expect(page).to have_link('Github', href: 'https://github.com')

    first('.bookmark').click_button('Delete')

    expect(current_path).to eq('/bookmarks')
    expect(page).to_not have_link('Github', href: 'https://github.com')
  end
end