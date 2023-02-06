module Api
  module V1
    class ServicesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def contact_us
        begin
          unless contact_params.present?
            return display_error('All params are not present')
          end

          if contact_params.present?
            @contact_us = Contact.new(contact_params)
            if  @contact_us.save!
              render json: {api_status: true, locale: I18n.locale.to_s,contact_us: @contact_us}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @contact_us.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @contact_us.errors.full_messages}
        end
      end


      private

      def contact_params
        params.permit( :name, :email, :phone, :message, :user_id )
      end
        def user
        @user ||= current_user
      end

    end
  end
end
