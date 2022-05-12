require 'pg'

def database_bookmarks(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  
  connection.query(
    "SELECT * FROM bookmarks WHERE id = $1;", [id]
  )
end