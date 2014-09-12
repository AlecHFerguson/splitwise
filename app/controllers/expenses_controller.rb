class ExpensesController < ApplicationController
  include ExpensesHelper, SessionsHelper
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
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
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update(params_to_save)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(C_NAME, C_AMOUNT, C_DESCRIPTION)
    end

    def params_to_save
      expense_params.merge(user_id: current_user.id)
    end
end
