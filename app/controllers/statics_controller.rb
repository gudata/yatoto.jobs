class StaticsController < ApplicationController
  def homepage
    session.clear
  end
end
