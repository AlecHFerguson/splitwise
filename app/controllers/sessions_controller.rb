class SessionsController < ApplicationController

  def index
    redirect_to :login
  end

  def login
    if current_user
      redirect_to({controller: :dashboard})
    end
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in user
      redirect_to(controller: :dashboard)
    else
      flash[:error] = 'Invalid email or password'
      render :login
    end
  end

  def destroy
    sign_out
  end

  private
    def session_params
      params.require(:session).permit(:email, :password, :remember_token)
    end
end
