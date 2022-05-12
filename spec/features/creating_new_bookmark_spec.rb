feature "adding bookmarks to the page" do
  scenario 'add bookmark to bookmark manager' do
    visit '/bookmarks/new'
    fill_in "url", with: "http://www.facebook.com"
    fill_in "title", with: "Facebook"
    click_button "Submit"
    expect(page).to have_link 'Facebook', href: "http://www.facebook.com"
  end

  scenario 'bookmark must be a valid URL' do
    visit '/bookmarks/new'
    fill_in "url", with: "not a url"
    fill_in "title", with: "title"
    click_button "Submit"

    expect(page).not_to have_link "title", href: "not a url"
    expect(page).to have_content "You must submit a valid URL."
  end
end
