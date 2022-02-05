class Api::V1::BaseController < Api::BaseController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def record_not_found(exception)
    render json: { message: "resource not found" }, status: :not_found
  end

  def user_not_authorized
    render json: { message: "You are not authorized to perform this action." }, status: :forbidden
  end
end