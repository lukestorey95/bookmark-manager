feature 'viewing bookmarks' do
  scenario 'user can view bookmark' do
    Bookmark.create(url: "http://www.makersacademy.com")
    Bookmark.create(url: "http://www.destroyallsoftware.com")
    Bookmark.create(url: "http://www.bbc.co.uk")

    visit('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.bbc.co.uk"
    expect(page).to have_content "http://www.destroyallsoftware.com"  
  end
end
