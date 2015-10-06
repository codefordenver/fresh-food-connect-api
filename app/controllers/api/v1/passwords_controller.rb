class Api::V1::PasswordsController < DeviseTokenAuth::PasswordsController
  def update
  	@resource = resource_class.reset_password_by_token(resource_params)
      unless @resource
        return render json: {
          errors: ['Unauthorized']
        }, status: 401
      end

      # make sure account doesn't use oauth2 provider
      unless @resource.provider == 'email'
        return render json: {
          errors: [I18n.t("devise_token_auth.passwords.password_not_required", provider: @resource.provider.humanize)]
        }, status: 422
      end

      # ensure that password params were sent
      unless password_resource_params[:password]
        return render json: {
          errors: [I18n.t("devise_token_auth.passwords.missing_passwords")]
        }, status: 422
      end

      if @resource.send(resource_update_method, password_resource_params)
        yield if block_given?
        return render json: {
          success: true,
          data: {
            user: @resource,
            message: I18n.t("devise_token_auth.passwords.successfully_updated")
          }
        }
      else
        return render json: {
          errors: @resource.errors.full_messages
        }, status: 422
      end
  end
end