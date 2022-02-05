class Api::V1::BaseController < Api::BaseController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(exception)
    render json: { message: "resource not found" }, status: :not_found
  end
end