class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!, except: :options
  before_action :cors_set_access_control_headers

  rescue_from Exceptions::AuthorizationError, with: :not_authorized
  rescue_from Exceptions::QueryError, with: :invalid_query_string
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def options
    cors_set_access_control_headers
    render :text => "", :layout => false
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']   = request.env['HTTP_ORIGIN']
    headers["Access-Control-Request-Method"] = "*"
    headers['Access-Control-Allow-Methods']  = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers']  = '*,x-requested-with,Content-Type, user-email, accept, token'
    headers['Access-Control-Max-Age']        = "1728000"
  end

  def ensure_admin_user
    raise Exceptions::AuthorizationError unless current_user.admin?
  end

  def ensure_owner_of_resource
    raise Exceptions::AuthorizationError unless params[:user_id].to_i == current_user.id or current_user.admin?
  end

  def not_authorized(exception)
    render json: { errors: exception.to_s }, status: :forbidden
  end

  def resource_not_found(exception)
    render json: { errors: exception.message }, status: :not_found
  end

  def invalid_query_string(exception)
    render json: { errors: exception.message }, status: :bad_request
  end
end
