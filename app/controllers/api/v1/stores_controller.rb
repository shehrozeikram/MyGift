module Api
  module V1
    class StoresController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!

      def fetch_stores #For product search
        begin
          if params[:q].present?
            @stores = Store.where("LOWER(store_name) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:store_id]
            @stores =Store.find(params[:store_id])
          else
            @stores =Store.all.order(store_name: :asc)
          end

          if I18n.locale.to_s == "ar"
            @stores.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, stores: @stores}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, stores: @stores}
        end
      end

      def create_store_payment
        begin
          unless payment_params.present?
            return display_error('All params are not present')
          end
          if payment_params.present?
            @user = User.find(params[:user_id])
            @user_wallet = @user.wallets.first
            if @user_wallet.balance >= params[:amount].to_f
              @payment = Payment.new(payment_params)
              @payment.save!
              new_price_of_wallet = @user_wallet.balance - @payment.amount
              @user_wallet.balance = new_price_of_wallet
              @user_wallet.save
              @store_balance = @payment.store.balance
              new_price_of_store_wallet = @store_balance + @payment.amount
              @payment.store.balance = new_price_of_store_wallet
              @payment.store.save!
              render json: {api_status: true, locale: I18n.locale.to_s, payment: @payment.as_json( :include => [:user] ), user_wallet: @user_wallet }
            end

          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @payment.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @payment.errors}
        end
      end

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
      def payment_params
        params.permit(:amount, :user_id, :store_id)
      end

      def user
        @user ||= current_user
      end

    end
  end
end
