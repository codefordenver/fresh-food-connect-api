module AuthenticationHelper
  def set_auth_headers_for(user)
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end
end
