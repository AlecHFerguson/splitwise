class SessionsController < ApplicationController

  def login
    render 'login'
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to dashboard
    else
      flash[:error] = 'Invalid email or password'
      render 'login'
    end
  end

  def destroy
    sign_out
  end
end
