require 'pg'

def database_bookmarks(id:)
  con = PG.connect(dbname: 'bookmark_manager_test')
  res = con.query("SELECT * FROM bookmarks WHERE id = #{id};")
end