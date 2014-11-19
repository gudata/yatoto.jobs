require 'active_model'
class Question
  include ::ActiveModel::Validations
  include ::ActiveModel::Conversion
  extend ::ActiveModel::Naming

  attr_accessor :answer
  attr_accessor :question
  validates_presence_of :answer
  validates_length_of :answer, :minimum => 3

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save
    valid?
  end

end