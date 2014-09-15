class DashboardController < ApplicationController
  include SessionsHelper, ApplicationHelper
  before_action :require_login
  before_action :get_all_tabs

  def index
    @expenses = Expense.where(user_id: current_user.id)
    render 'index'
  end
end
