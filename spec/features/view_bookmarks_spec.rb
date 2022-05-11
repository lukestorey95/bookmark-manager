feature 'viewing bookmarks' do
  scenario 'user can view bookmark' do
    Bookmark.create(url: "http://www.makersacademy.com", title: 'Makers Academy')
    Bookmark.create(url: "http://www.bbc.co.uk", title: 'BBC')
    Bookmark.create(url: "http://www.destroyallsoftware.com", title: 'Destroy Software')

    visit('/bookmarks')

    expect(page).to have_link('Makers Academy', href: "http://www.makersacademy.com") 
    expect(page).to have_link('BBC', href: "http://www.bbc.co.uk") 
    expect(page).to have_link('Destroy Software', href: "http://www.destroyallsoftware.com") 
  end
end
