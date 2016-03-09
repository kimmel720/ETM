class FrontEndController < ApplicationController
  before_action :authorize

  protected
  def authorize
    unless User.find_by(id: session[:user_id], admin: true)
      redirect_to login_url, notice: "You are not admin! Please log in!"
    end
  end
end
