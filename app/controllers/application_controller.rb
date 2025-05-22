# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :track_visits

  private

  def track_visits
    session[:visit_count] ||= 0
    session[:visit_count] += 1
    @visit_count = session[:visit_count]

    session[:page_visits] ||= {}
    page_key = "#{controller_name}##{action_name}"
    session[:page_visits][page_key] ||= 0
    session[:page_visits][page_key] += 1
    @page_visit_count = session[:page_visits][page_key]

    @last_visited = session[:last_visited]
    session[:last_visited] = Time.current
  end
end