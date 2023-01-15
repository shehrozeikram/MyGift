module Api
  module V1
    class ResturantsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def show_resturant
        begin
          unless params[:id].present?
            return  display_error("Service ID is missing!")
          end
          if params[:id].present?
            @resturant = Resturant.find(params[:id])
            return display_error("Service Not  Present ")  unless @resturant.present?
          end

          if I18n.locale.to_s == "ar"
            @resturant.description = @resturant.ar_description
            @resturant.title = @resturant.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, resturant: @resturant }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      private

      def user
        @user ||= current_user
      end

    end
  end
end
