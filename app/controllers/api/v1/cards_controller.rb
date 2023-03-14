module Api
  module V1
    class CardsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!


      def fetch_user_wallet
        begin
          if params[:user_id]
            user = User.find(params[:user_id])
            @user_balance = user.wallets.first.balance
          else
            @user_balance =User.all.order(username: :asc)
          end

          if I18n.locale.to_s == "ar"
            @user_balance.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, user_balance: @user_balance}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, user_balance: @user_balance}
        end
      end


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

      def fetch_claim_rewards
        begin
          if params[:user_id].present?
            @rewards  = Reward.where(receiver_id: params[:user_id]).where(claim: false)
          else
            @rewards =Reward.all
          end

          if I18n.locale.to_s == "ar"
            @rewards.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, claim_rewards: @rewards.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, claim_rewards: @rewards}
        end
      end


      def claim_reward
        begin
          if params[:reward_id].present?
            @claim_reward = Reward.where(id: params[:reward_id])
            @claim_reward.update(claim: true )
          else
            @claim_reward =Reward.all
          end
          if I18n.locale.to_s == "ar"
            @claim_reward.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, claim_reward: @claim_reward.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, errors: @claim_reward.errors }
        end
      end

      def fetch_transactions #For product search
        begin
          if params[:user_id].present?
            @transactions  = Transaction.where(user_id: params[:user_id])
          else
            @transactions =Transaction.all
          end

          if I18n.locale.to_s == "ar"
            @transactions.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, transactions: @transactions.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, transactions: @transactions}
        end
      end


      def fetch_rewards
        begin
          if params[:user_id].present?
            @rewards  = Reward.where(receiver_id: params[:user_id]).where(claim: true)
          else
            @rewards =Reward.all
          end

          if I18n.locale.to_s == "ar"
            @rewards.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, latest_rewards: @rewards.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, latest_rewards: @rewards}
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
