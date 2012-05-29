class UsersController < ActionController::Base
  def subscribe
    User.create(:email => params[:email], :password => params[:password])
	render :text => "ok"
  rescue
    render :text => "error"
  end
  
  def unsubscribe
    user = User.authenticate(params[:email], params[:password])
	user.destroy if user
	render :text => "ok"
  rescue
    render :text => "error"
  end
end

