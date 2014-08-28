class SessionsController < ApplicationController

  def login
    render 'login'
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])

    else

    end
  end

  def destroy

  end
end
