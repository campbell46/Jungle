class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email/password, please try again'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end

end
