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

      def fetch_store_id #For product search
        begin
          if params[:user_id]
            @stores = Store.where(user_id: params[:user_id])
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
      def fetch_store_wallet
        begin
          if params[:store_id]
            store =Store.find(params[:store_id])
            @store_balance = store.balance
          else
            @store_balance =Store.all.order(store_name: :asc)
          end

          if I18n.locale.to_s == "ar"
            @store_balance.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, store_balance: @store_balance}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, store_balance: @store_balance}
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
              if @payment.store.save!
                @notification = @payment.store.notifications.new(
                  body: @user.first_name  + 'just pay at store' ,
                  amount: params[:amount],
                  store_id: params[:store_id],
                  user_id: params[:user_id]
                )
                if @notification.save!
                  render json: {api_status: true, locale: I18n.locale.to_s, payment: @payment.as_json( :include => [:user] ), user_wallet: @user_wallet, notification: @notification }
                end
              end

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

      def fetch_notifications #For product search
        begin
          if params[:q].present?
            @notifications = Notification.where("LOWER(body) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:store_id]
            @store = Store.find(params[:store_id])
            @notifications = @store.notifications
          else
            @notifications = Notification.all
          end

          if I18n.locale.to_s == "ar"
            @notifications.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, notifications: @notifications}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, notifications: @notifications}
        end
      end

      def create_withdraw
        begin
          unless withdraw_params.present?
            return display_error('All params are not present')
          end

          if withdraw_params.present?
            @user = User.find(params[:user_id])
            @user_wallet = @user.wallets.first
            if @user_wallet == nil
              @user_wallet.create(
                balance: 500000,
                user_id: params[:user_id]
              )
              @user_wallet.save
            end
            if @user_wallet.balance >= params[:total_payment].to_f
              @withdraw_payment = Withdraw.new(withdraw_params)
              if  @withdraw_payment.save!
                new_price_of_wallet = @user_wallet.balance - @withdraw_payment.total_payment
                @user_wallet.balance = new_price_of_wallet
                @user_wallet.save
                @store_balance = @withdraw_payment.store.balance
                new_price_of_store_wallet = @store_balance + @withdraw_payment.total_payment
                @withdraw_payment.store.balance = new_price_of_store_wallet
                @withdraw_payment.store.save!
                render json: {api_status: true, locale: I18n.locale.to_s, withdraw_payment: @withdraw_payment.as_json( :include => [:user] ), user_wallet: @user_wallet}
              end
            else
              render json: {api_status: false, locale: I18n.locale.to_s, error: @withdraw_payment.errors}
            end
            end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @withdraw_payment.errors.full_messages}
        end
      end

      def pending_requests
        begin
          if params[:q].present?
            @pending_requests = Withdraw.where("LOWER(id) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:store_id]
            @store = Store.find(params[:store_id])
            @pending_requests = @store.withdraws.where(is_completed:false )
          else
            @pending_requests = Withdraw.where(is_completed:false )
          end

          if I18n.locale.to_s == "ar"
            @pending_requests.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, pending_requests: @pending_requests}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, pending_requests: @pending_requests}
        end
      end

      def approved_requests
        begin
          if params[:q].present?
            @approved_requests = Withdraw.where("LOWER(id) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:store_id]
            @store = Store.find(params[:store_id])
            @approved_requests = @store.withdraws.where(is_completed:true )
          else
            @approved_requests = Withdraw.where(is_completed:true )
          end

          if I18n.locale.to_s == "ar"
            @approved_requests.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, approved_requests: @approved_requests}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, approved_requests: @approved_requests}
        end
      end

      def update_request
        begin
          if params[:withdraw_id].present?
            @withdraw_request = Withdraw.find(params[:withdraw_id]).update(is_completed: true)
            @result_request = Withdraw.where(id: params[:withdraw_id])
          end

          if I18n.locale.to_s == "ar"
            @withdraw_request.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, withdraw_request: @withdraw_request, result_request: @result_request }
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, withdraw_request: @withdraw_request}
        end
      end

      private

      def withdraw_params
        params.permit( :card_holder_name, :iban_number, :billing_address, :cvc, :expire_date, :total_payment, :user_id, :store_id )
      end
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
