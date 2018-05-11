require 'pg'

class Bookmark
  attr_reader :title, :url, :id

  def initialize(title, url, id)
    @title = title
    @url = url
  end

  def self.all
    result = choose_database.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['title'], bookmark['url'], bookmark['id']) }
  end

  def self.create(title, url)
    if  url =~ URI::regexp
      choose_database.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}');")
      result = choose_database.exec("SELECT * FROM bookmarks")
      result.map { |bookmark| Bookmark.new(bookmark['title'], bookmark['url'], bookmark['id']) }
    else
      false
    end
  end

  def self.delete(title)
    choose_database.exec("DELETE FROM bookmarks WHERE title = '#{title}';")
  end

  def self.update(current_title, new_title)
    choose_database.exec("UPDATE bookmarks SET title = '#{new_title}' WHERE title = '#{current_title}'")
  end

  private

  def self.choose_database
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end

end
