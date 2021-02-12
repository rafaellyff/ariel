module Api
  module V1
    class BaseController < ApplicationController
      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      respond_to :json
    end
  end
end
