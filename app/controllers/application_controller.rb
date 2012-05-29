class ApplicationController < ActionController::Base
  force_ssl
  before_filter :authenticate, :except => [:login, :subscribe, :unsubscribe]
  
  private
  def authenticate
    if current_user.nil?
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
		else
			render :text => "unauthorized", :status => :unauthorized
		end
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end

