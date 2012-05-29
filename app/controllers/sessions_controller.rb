class SessionsController < ApplicationController
  def login
    user = User.authenticate(params[:email], params[:password])
    if user.nil? || user == false
      render :text => "error"
    else
      session[:user_id] = user.id
      render :text => "ok"
    end
  end

  def logout
    session[:user_id] = nil
    render :text => "ok"
  end
end

