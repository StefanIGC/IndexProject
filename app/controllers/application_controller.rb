class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        render json: { error: 'Access Denied' }, status: :forbidden
    end

    protected


    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :role])
    end
end
