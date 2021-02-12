module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        acts_as_token_authentication_handler_for User
        
        skip_before_action :authenticate_entity_from_token!, only: [:create], raise: false
        skip_before_action :authenticate_entity!, only: [:create], raise: false
  
        skip_before_action :authenticate_scope!, raise: false
        append_before_action :authenticate_scope!, only: [:destroy]
  
  
        # POST /users
        def create
          build_resource(sign_up_params)
  
          if resource.save
            sign_up(resource_name, resource)
            head :created
          else
            clean_up_passwords resource
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
  
        # DELETE /users/:id
        def destroy
          resource.deactivated_at = DateTime.now
          resource.save!
          Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        end
  
        private
  
        def sign_up_params
          params.fetch(:user).permit([:password, :passwordConfirmation, :email, :name])
        end
      end
    end
  end
end
