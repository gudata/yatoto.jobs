require 'active_model'
class Question
  include ActiveModel::Model

  attr_accessor :answer
  attr_accessor :line1
  attr_accessor :line2
  attr_accessor :line3
  attr_accessor :line4
  attr_accessor :line5
  attr_accessor :question
  attr_accessor :start
  attr_accessor :step
  attr_accessor :duration

  validates :answer, presence: true, if: ->(instance) { instance.line1.blank? }
  validates :line1, presence: true, if: ->(instance) { instance.answer.blank? }


  def initialize params, step, session
    @step = step
    @session = session
    @session[@step] ||= {}
    super params if params
    @answer ||= @session[@step]['answer']
    @line1 ||= @session[@step]['line1']
    @line2 ||= @session[@step]['line2']
    @line3 ||= @session[@step]['line3']
    @line4 ||= @session[@step]['line4']
    @line5 ||= @session[@step]['line5']
  end

  def persisted?
    false
  end

  def save session=nil
    @session[@step]['answer'] = self.answer

    @session[@step]['line1'] = self.line1
    @session[@step]['line2'] = self.line2
    @session[@step]['line3'] = self.line3
    @session[@step]['line4'] = self.line4
    @session[@step]['line5'] = self.line5

    valid?
  end

end