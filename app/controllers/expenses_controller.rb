class ExpensesController < ApplicationController
  include ExpensesHelper, SessionsHelper
  before_action :require_login

  def index
    redirect_to({controller: :dashboard})
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params_to_save)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render action: 'show', status: :created, location: @expense }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private
    def expense_params
      params.require(:expense).permit(C_NAME, C_AMOUNT, C_DESCRIPTION)
    end

    def params_to_save
      expense_params.merge(user_id: current_user.id)
    end
end
