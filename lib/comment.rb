class Comment

  attr_reader :text

  def initialize(text)
    @text = text
  end

  def self.create(text)
    choose_database.exec("INSERT INTO Comments (text) VALUES('#{text}');")
  end

  def self.all
    result = choose_database.exec("SELECT * FROM Comments")
    result.map { |comment| Comment.new(comment['text']) }
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
