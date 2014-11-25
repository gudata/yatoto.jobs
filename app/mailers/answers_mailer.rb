class AnswersMailer < ActionMailer::Base
  default from: ENV['CANDIDATES_EMAILS_FROM']
  def new_candidate position, questions, email_title
    @position = position
    @questions = questions

    mail to: ENV['CANDIDATES_EMAILS_TO'], subject: email_title
  end
end
