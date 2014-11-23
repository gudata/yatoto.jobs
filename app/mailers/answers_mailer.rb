class AnswersMailer < ActionMailer::Base
  default from: "from@example.com"
  def new_candidate position, questions
    @position = position
    @questions = questions
    mail to: 'i.bardarov@gmail.com', subject: "Hello!"
  end
end
