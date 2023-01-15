module Api
  module V1
    class BusinessesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_business #For product search
        begin
          if params[:q].present?
            @business = Business.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:tags]
            @business =Business.tagged_with(params[:tags]).order(title: :asc)
          else
            @business =Business.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @business.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, business: @business}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, business: @business}
        end
      end



      def show_business
        begin
          unless params[:id].present?
            return  display_error("Business ID is missing!")
          end
          if params[:id].present?
            @business = Business.find(params[:id])
            return display_error("Business Not  Present ")  unless @business.present?
          end

          if I18n.locale.to_s == "ar"
            @business.description = @business.ar_description
            @business.title = @business.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, business: @business }
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
