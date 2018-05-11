require 'pg'

p 'setting up test database'

def reset_database
  connection = PG.connect(dbname: 'bookmark_manager_test')


  connection.exec("TRUNCATE bookmarks CASCADE;")

end
