module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      # include ExceptionHandler
      include ActAsApiRequest
      # include Localizable

      private

      def sign_up_params
        params.permit(:email, :password, :first_name, :last_name, :username,  :address, :locale, :avatar, :contact_number )
      end

      def render_create_success
        render :create
      end

      def render_create_error
        raise ActiveRecord::RecordInvalid, @resource
      end

      def validate_post_data(which, message)
        render_errors(message, :bad_request) if which.empty?
      end
    end
  end
end
