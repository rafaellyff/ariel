module Api
  module V1
    class BaseController < ApplicationController
      before_action :configure_permitted_parameters, if: :devise_controller?
      respond_to :json

      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      
     #before_action :require_authentication!
      
      private
      
      def require_authentication!
        throw(:warden, scope: :user) unless current_user.presence
      end
    
      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      end
      
    end
  end
end
