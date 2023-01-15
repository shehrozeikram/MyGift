module Api
  module V1
    class OrdersController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Create Order

      def create_order
        begin
          unless order_params.present?
            return display_error('All params are not present')
          end
          if order_params.present?
            @order = Order.new(order_params)
            if @order.save_locations == true
              @order.user.save_location_latitude = @order.latitude
              @order.user.save_location_longitude = @order.longitude
            end
            if  @order.save!
              render json: {api_status: true, locale: I18n.locale.to_s, order: @order}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @order.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @order.errors}
        end
      end

      private

      def order_params
        params.permit(:order_detail, :comment, :delivery_address, :coupon, :save_locations, :longitude, :latitude, :user_id)
      end

    end
  end
end
