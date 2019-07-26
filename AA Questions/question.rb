require_relative 'questionsDatabase'
require_relative 'user'
require_relative 'replies'

class Question
  attr_accessor :title, :body, :associated_author_id, :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @title = options['title']
    @associated_author_id = options['associated_author_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL
    data.map { |datum| Question.new(datum)}
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions
      WHERE associated_author_id = ?
    SQL
    data.map { |datum| Question.new(datum)}    
  end

  def author
    User.all.select{ |user| user.id == associated_author_id }
  end

  def replies 
    Reply.find_by_question_id(@id)
  end

end
