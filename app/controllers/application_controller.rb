class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  skip_before_action :verify_authenticity_token

  allow_browser versions: :modern
  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])  || User.first # Assuming you're using session-based authentication
  end

  def current_user
    @current_user
  end
end
