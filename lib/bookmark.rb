require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all

    # array = []

    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end    
    
    rs = con.exec "SELECT * FROM bookmarks"
    
    rs.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
    
    # rs.each do |row|
    #   array << row['url']
    # end
    
    # return array
    
  end
  
  def self.create(url:, title:)
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end     
    
    res = con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")

    Bookmark.new(id: res[0]['id'], title: res[0]['title'], url: res[0]['url'])
  end
end
