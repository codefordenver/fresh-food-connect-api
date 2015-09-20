# Raise this exception when a request is made for a server resource
# for which the current user does not have the necessary permissions
# or role.

class Exceptions::AuthorizationError < SecurityError

  def message
    "You are not authorized to perform this action"
  end

  def to_s
    "Authorization Error: #{message}"
  end
end