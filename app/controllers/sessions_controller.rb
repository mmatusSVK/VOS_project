class SessionsController < ApplicationController

  def new
    redirect_to current_user unless current_user.nil?
  end

  def create
    user = User.find_by(login_name: params[:session][:login_name])
    if user && user.authenticate(params[:session][:password])
      log_in_new_user user
      flash[:success] = 'Prihlásenie prebehlo úspešne.'
      redirect_to user
    else
      flash.now[:danger] = 'Nesprávna kombinácia email/heslo.'
      render 'new'
    end
  end

  def destroy
    log_out_current_user
    redirect_to root_url
  end

end
