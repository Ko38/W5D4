require_relative 'question_follow'
require_relative 'question_like'
require_relative 'question'
require_relative 'replies'
require_relative 'user'

replies = Reply.all
# p replies[0].author
# p replies[0].question
# p replies[0].parent_reply
# p replies[1].parent_reply
# p replies[0].child_replies

p Question_follow.followers_for_question_id(1)