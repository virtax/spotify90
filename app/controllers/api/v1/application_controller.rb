class Api::V1::ApplicationController < ActionController::API

  def not_found
    head :not_found
  end

end