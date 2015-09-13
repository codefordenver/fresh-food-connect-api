class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!, except: :options
  before_action :cors_set_access_control_headers

  def options
    cors_set_access_control_headers
    render :text => "", :layout => false
  end

  private 

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
    headers["Access-Control-Request-Method"] = "*"
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type, user-email, accept, token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
