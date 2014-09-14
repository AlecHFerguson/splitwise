class TabsController < ApplicationController
  include TabsHelper
  before_action :set_tab, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :exclude_non_owner, only: [:edit, :update, :show, :destroy]

  def index
    redirect_to({controller: :dashboard})
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new(params_to_save)

    respond_to do |format|
      if @tab.save
        format.html { redirect_to @tab, notice: 'Tab was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tab }
      else
        format.html { render action: 'new' }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private
    def set_tab
      @tab = Tab.find(params[:id])
      @expenses = Expense.where(user_id: current_user.id, tab_id: params[:id])
      @total_amt = 0
      @expenses.each do |e|
        @total_amt += e.amount
      end
    end

    def tab_params
      params.require(:tab).permit(C_NAME, C_DESCRIPTION)
    end

    def params_to_save
      tab_params.merge(user_id: current_user.id)
    end

    def exclude_non_owner
      tab = Tab.find_by_id(params[:id])
      unless tab.user_id == current_user.id
        redirect_to({controller: :dashboard})
      end
    end
end
