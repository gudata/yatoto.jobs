require 'active_model'
class Question
  include ActiveModel::Model

  attr_accessor :answer
  attr_accessor :question
  attr_accessor :start
  attr_accessor :step
  attr_accessor :duration

  validates_presence_of :answer
  validates_length_of :answer, :minimum => 3

  def initialize params, step, session
    @step = step
    @session = session
    @session[@step] ||= {}
    super params if params
    @answer ||= @session[@step]['answer']
  end

  def persisted?
    false
  end

  def save session=nil
    valid?
    @session[@step]['answer'] = self.answer
  end

end