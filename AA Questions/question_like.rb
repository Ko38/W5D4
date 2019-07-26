require_relative 'questionsDatabase'

class Question_like
  attr_accessor  :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| Question_like.new(datum) }
  end

  def initialize(options)
 
    @user_id = options['user_id']
    @question_id = options['question_id']
  end


end

