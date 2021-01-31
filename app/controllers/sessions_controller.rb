class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
        session[:user_id] = user.id
        redirect_to root_path
    else
        flash.now[:notice] = 'Invalid email or password'
        render action: :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
