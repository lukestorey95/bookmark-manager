require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      con = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: 'Makers Academy')
      Bookmark.create(url: "http://www.bbc.co.uk", title: 'BBC')
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: 'Destroy Software')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'

    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Example title')
      database_bookmark = persisted_data(table: 'bookmarks', id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq database_bookmark.first['id']
      expect(bookmark.url).to eq 'http://www.example.org'
      expect(bookmark.title).to eq 'Example title'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a url', title: 'title')
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes the specified bookmark' do
      bookmark = Bookmark.create(url: 'https://www.reddit.com/', title: 'Reddit')
      
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the specified bookmark' do
      bookmark = Bookmark.create(url: 'https://www.reddit.com/', title: 'Reddit')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'https://www.beddit.com/', title: 'Beddit')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Beddit'
      expect(updated_bookmark.url).to eq 'https://www.beddit.com/'
    end
  end

  describe '.find' do
    it 'finds the specified bookmark' do
      bookmark = Bookmark.create(url: 'https://www.reddit.com/', title: 'Reddit')

      found_bookmark = Bookmark.find(id: bookmark.id)

      expect(found_bookmark).to be_a Bookmark
      expect(found_bookmark.id).to eq bookmark.id
      expect(found_bookmark.title).to eq 'Reddit'
      expect(found_bookmark.url).to eq 'https://www.reddit.com/'
    end
  end

  let(:comment_class) { double(:comment_class) }

  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(url: 'https://example.com/', title: 'Example')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end
end
