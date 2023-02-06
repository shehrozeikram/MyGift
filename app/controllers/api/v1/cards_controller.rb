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


      def create_gift
        begin
          unless params[:card_id].present?
            return display_error('card_id is not present')
          end

          if params[:card_id].present?
          @card =  Card.find(params[:card_id])
          end

          unless gift_params.present?
            return display_error('All params are not present')
          end

          if gift_params.present?
            @gift = Gift.new(gift_params)
            if  @gift.save!

              @transaction = @gift.transactions.new(
                id: rand(10 * 100),
                title: "Birthday Gift Card",
                send_date: "12/2/2023",
                amount: @card.price,
                user_id: @gift.user_id,
                gift_id: @gift.id,
                created_at: @gift.created_at,
                updated_at: @gift.updated_at
              )
              if @transaction.save!

                receiver_user = User.where(contact_number: @gift.receiver_phone_number).where.not(id: @gift.user_id)
                if receiver_user.any?
                  @receiver_id = receiver_user.first.id
                  @reward = @gift.rewards.new(
                    id: rand(10 * 100),
                    title: "Birthday Gift Card",
                    send_date: "12/2/2023",
                    amount: @card.price,
                    user_id: @gift.user_id,
                    gift_id: @gift.id,
                    receiver_id: @receiver_id ,
                    created_at: @gift.created_at,
                    updated_at: @gift.updated_at
                  )
                  @reward.save!
                render json: {api_status: true, locale: I18n.locale.to_s,card: @card, gift: @gift, transaction:@transaction, reward:@reward }
                else
                  render json: {api_status: false, locale: I18n.locale.to_s, error: @gift.errors.full_messages}

                end
                end
            end

                end

        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @gift.errors.full_messages}
        end
      end

      def claim_gift
        begin
          if params[:id].present?
            @claim_gift = Gift.where(id: params[:id])
            @claim_gift.update("claim_gift": true )
          else
            @claim_gift =Gift.all
          end
          if I18n.locale.to_s == "ar"
            @claim_gift.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, claim_gift: @claim_gift}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s}
        end
      end

      private
      def gift_params
        params.permit( :sender_name, :receiver_name, :receiver_phone_number, :your_message, :card_id, :user_id , attachments: [])
      end

      def transaction_params
        params.permit( :title, :send_date, :amount, :user_id, :gift_id)
      end

      def reward_params
        params.permit( :title, :send_date, :amount, :user_id, :gift_id, )
      end


      def user
        @user ||= current_user
      end

    end
  end
end
