class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def current_user
    @user = User.first
  end
end
