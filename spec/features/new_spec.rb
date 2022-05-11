feature "adding bookmarks to the page" do
  scenario 'add bookmark to bookmark manager' do
    visit '/bookmarks/new'
    fill_in "url", with: "http://www.bbc.co.uk"
    click_button "Submit"
    expect(page).to have_content "http://www.bbc.co.uk"
  end
end
