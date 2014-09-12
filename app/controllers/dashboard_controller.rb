class DashboardController < ApplicationController
  include SessionsHelper
  before_action :require_login

  def index
    @expenses = Expense.where(user_id: current_user.id)
    render 'index'
  end
end
