class Api::ApiController < ActionController::API
  attr_accessor :current_user

  before_action :set_default_format

  private

  def set_default_format
    request.format = :json
  end
end
