require_relative 'questionsDatabase'

class Question_follow
  attr_accessor :user_id, :question_id, :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| Question_follow.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_follows.id = ?
    SQL
    data.map { |datum| Question_follow.new(datum)}
  end    

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
      users.id, users.fname, users.lname
      FROM
      users
      JOIN 
      question_follows ON users.id = user_id
      WHERE
      question_id = ?
    SQL
    data.map { |datum| User.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
      questions.title, questions.body, questions.associated_author_id
      FROM
      questions
      JOIN
      question_follows ON questions.id = question_id
      GROUP BY
        question_id
      
    
    SQL
    data.map { |datum| Question.new(datum)}
  end

end