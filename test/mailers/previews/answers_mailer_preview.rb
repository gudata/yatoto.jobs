# Preview all emails at http://localhost:3000/rails/mailers/answers_mailer
class AnswersMailerPreview < ActionMailer::Preview
  def new_candidate
    question = Question.new(nil, '1000', {})
    question.start = Time.now
    question.duration = "123.:@!3"
    question.answer = "ho chares"
    questions = []
    questions << question
    AnswersMailer.new_candidate 'Administrator', questions
  end
end
