require 'pg'

def empty_test_bookmarks
  con = PG.connect :dbname => 'bookmark_manager_test'

  con.exec "TRUNCATE bookmarks, comments"
end
