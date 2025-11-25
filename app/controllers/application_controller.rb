class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :nom, :prenom,])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :nom, :prenom,])
    end

    # def require_role(role)
    #     unless current_user && current_user.role == role
    #         redirect_to root_path, alert: "Accès refusé"
    #     end
    #     #before_action -> { require_role("admin") }

    # end
end
