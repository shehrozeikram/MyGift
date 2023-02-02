module Api
  module V1
    class CardsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def fetch_cards
        begin
          if params[:q].present?
            @cards = Card.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:id]
            @cards = Card.find(params[:id])
          else
            @cards =Card.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @cards.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, cards: @cards}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, cards: @cards}
        end
      end


      private

      def user
        @user ||= current_user
      end

    end
  end
end
