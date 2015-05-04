class WizardController < ApplicationController
  include Wicked::Wizard

  before_action -> {
    ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 3.days.ago])
  }

  before_action :set_steps
  before_action :setup_wizard

  before_action :calc_progressbar, only: [:show, :update]

  before_action :start_timer, only: :show
  before_action :stop_timer, only: :update
  # before_action :prevent_jumping

  def prevent_jumping
    return if Wicked::FIRST_STEP == step or session[step].key? 'passed'
    redirect_to previous_wizard_path
    return false
  end

  def show
    @question = Question.new(params[:question], step, session)
    case step
    when :question_1
    end
    render_wizard
  end

  def update
    @question = Question.new(params[:question], step, session)

    if @question.save
      session[step]['passed'] = '1'
    end

    if step =~ /send_contacts/
      questions = steps.collect do |step|
        question = Question.new(nil, step, session)
        question.start = session[step]['start']
        question.duration = session[step]['duration']
        question
      end
      AnswersMailer.new_candidate(self.controller_name.capitalize, questions, self.controller_name).deliver
    end

    render_wizard @question
  end

  private

  def set_steps
    self.steps = Dir[File.join(Rails.root, "app", "views", controller_name, "*.slim")].map{|file_name|File.basename(file_name, ".html.slim").to_sym}.sort
  end

  def stop_timer
    stop_time(step)
  end

  def start_timer
    start_time(step)
  end

  def start_time step
    session[step] ||= {}
    session[step]['start'] ||= Time.now
    session[step]['start']
  end

  def stop_time step
    session[step] ||= {}
    started_at = session[step]['start'] || start_time(step)
    session[step]['duration'] = time_diff(started_at, Time.now)
  end

  def calc_progressbar
    return if step == 'wicked_finish'
    current_step_number = steps.index(step) + 1.0
    all_steps = steps.count
    @progressbar_value = ((current_step_number / all_steps ) * 100).round
    # steps_left = steps[steps.index(step)..-1].count
    # all_steps = steps.count
    # @progressbar_value = ((all_steps - steps_left).abs / ((all_steps + steps_left)/2.0) * 100).round
  end

  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

end
