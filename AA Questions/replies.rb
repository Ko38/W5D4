require_relative 'questionsDatabase'
require_relative 'user.rb'
require_relative 'question'

class Reply
  attr_accessor :id, :body, :subject_question_id, :user_id, :parent_reply_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @subject_question_id = options['subject_question_id']
    @body = options['body']
    @parent_reply_id = options['parent_reply_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL
    data.map { |datum| Reply.new(datum)}
  end  

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE replies.user_id = ?
    SQL
    data.map { |datum| Reply.new(datum)}
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE replies.subject_question_id = ?
    SQL
    data.map { |datum| Reply.new(datum)}
  end


  def author
    
    User.all.select { |user| user.id == user_id }
  end

  def question 
    Question.all.select { |question| question.id == subject_question_id}
  end

  def parent_reply
    Reply.all.select { |question| question.id == parent_reply_id}
  end

  def child_replies
    Reply.all.select { |question| question.parent_reply_id == id}
  end
end
