require 'pg'

def empty_bookmarks_test
  
  con = PG.connect :dbname => 'bookmark_manager_test'

  con.exec "TRUNCATE bookmarks"

end

# DONT NEED THIS METHOD ANYMORE
# def insert_bookmarks
#   con = PG.connect :dbname => 'bookmark_manager_test'
#   con.exec "INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com'), ('https://www.bbc.co.uk'), ('http://www.destroyallsoftware.com')"
# end
