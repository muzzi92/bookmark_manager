require 'comment'

describe Comment do

  describe '.create' do
    it 'adds a comment to the database' do
       connection = PG.connect(dbname: 'bookmark_manager_test')
       Comment.create('this is a comment')
       result = connection.exec("SELECT * FROM Comments")
       expect(result.values.flatten).to include('this is a comment')
    end
  end

  describe '.all' do
    it 'returns an array of comments' do
      Comment.create('this is a comment')
      expect(Comment.all[0].text).to eq('this is a comment')
    end
  end
end
