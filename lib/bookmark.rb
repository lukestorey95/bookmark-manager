require 'pg'
require_relative 'database_connection'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def self.all
    bookmarks = DatabaseConnection.query("SELECT * FROM bookmarks")

    bookmarks.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        url: bookmark['url'],
        title: bookmark['title']
      )
    end
  end
  
  def self.create(url:, title:)
    return false unless is_url?(url)

    result = DatabaseConnection.query(
      "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title]
    )
    Bookmark.new(
      id: result[0]['id'], title: result[0]['title'], url: result[0]['url']
    )
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1", [id])
  end

  def self.update(id:, title:, url:)
    result = DatabaseConnection.query(
      "UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;", [url, title, id]
    )
    Bookmark.new(
      id: result[0]['id'], title: result[0]['title'], url: result[0]['url']
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])
    Bookmark.new(
      id: result[0]['id'], title: result[0]['title'], url: result[0]['url']
    )
  end

  private

  def self.is_url?(url)
    url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
  end
end
