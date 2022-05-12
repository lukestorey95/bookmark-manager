feature 'updating a bookmark' do
  scenario 'user can update a bookmark' do
    bookmark = Bookmark.create(url: 'https://twitter.com/', title: 'Twitter')
    visit '/bookmarks'
    expect(page).to have_link('Twitter', href: 'https://twitter.com/')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'https://titter.com/')
    fill_in('title', with: 'Titter')
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Twitter', href: 'https://twitter.com/')
    expect(page).to have_link('Titter', href: 'https://titter.com/')
  end
end