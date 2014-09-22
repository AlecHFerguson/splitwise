class TabsController < ApplicationController
  include TabsHelper
  before_action :require_login
  before_action :set_tab, only: [:show, :edit, :update, :destroy]
  before_action :all_users, only: [:new, :edit]
  before_action :exclude_non_owner, only: [:edit, :update, :show, :destroy]

  def index
    redirect_to({controller: :dashboard})
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new(params_to_save)
    success = @tab.save ? true : false
    save_tab(success)
  end

  def update
    success = @tab.update(params_to_save) ? true : false
    save_tab(success, 'updated')
  end

  def edit
  end

  # DELETE /tabs/1
  # DELETE /tabs/1.json
  def destroy
    @tab.destroy
    respond_to do |format|
      format.html { redirect_to '/dashboard' }
      format.json { head :no_content }
    end
  end

  private
    def set_tab
      @tab = Tab.find(params[:id])
      @expenses = Expense.where(user_id: current_user.id, tab_id: params[:id])
      @total_amt = 0
      @expenses.each do |e|
        @total_amt += e.amount
      end

      @participants = User.joins('INNER JOIN participants ON participants.user_id = users.id').where(participants: { tab_id: @tab.id })
    end

    def all_users
      @all_users = User.all
    end

    def tab_params
      params.require(:tab).permit(C_NAME, C_DESCRIPTION, C_SPLITTERS => [])
    end

    def params_to_save
      tab_params.permit(C_NAME, C_DESCRIPTION).merge(user_id: current_user.id)
    end

    def checkbox_values
      tab_params[C_SPLITTERS]
    end

    def exclude_non_owner
      tab = Tab.find_by_id(params[:id])
      unless tab.user_id == current_user.id
        redirect_to({controller: :dashboard})
      end
    end

    # @param [TrueClass, FalseClass] success Whether the save or update was successful
    # @param [String] notice_status Use to create success message
    def save_tab(success, notice_status = 'created')
      if checkbox_values
        checkbox_values.each do |value|
          already_in_db = Participant.where(tab_id: @tab_id, user_id: value.to_i)
          if already_in_db.count == 0
            participant = Participant.new(tab_id: @tab.id, user_id: value.to_i)
            participant.save
          end
        end
      end

      respond_to do |format|
        if success
          format.html { redirect_to @tab, notice: "Tab was successfully #{notice_status}." }
          format.json { render action: 'show', status: :created, location: @tab }
        else
          format.html { render action: 'new' }
          format.json { render json: @tab.errors, status: :unprocessable_entity }
        end
      end
    end
end
