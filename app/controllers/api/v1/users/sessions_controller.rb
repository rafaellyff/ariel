module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json
        
        # POST /users/sign_in
        def create
          user = User.find_by_email(sign_in_params[:email])
      
          if user && user.valid_password?(sign_in_params[:password])
            render json: user
          else
            render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
          end
        end
  
        # DELETE /users/sign_out
        def destroy
          warden.authenticate!
          reset_token current_user
        end
  
        private
  
        def sign_in_params
          params.fetch(:user).permit([:password, :email])
        end
  
        def reset_token(resource)
          resource.authentication_token = nil
          resource.save!
        end
      end
    end
  end
end