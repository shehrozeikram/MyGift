module Api
  module V1
    class ApiController < ActionController::API
      # include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagy::Backend

      before_action :authenticate_user!
      skip_before_action :authenticate_user!, only: :default_locales

      def display_error(msg)
        render json: {api_status: false, error: msg}, status: 422
      end

      def display_success(msg)
        render json: {api_status: true, locale: I18n.locale.to_s, success: msg}, status: 200
      end

      def default_locales
        render json: {
          locale: I18n.locale.to_s,
          defaults: {
          email: I18n.t("email"),
          title: I18n.t("title"),
          description: I18n.t("description"),
          address: I18n.t("address"),
          categories: I18n.t("categories"),
          products: I18n.t("products"),
          buy_gift_for_myself: I18n.t("buy_gift_for_myself"),
          buy_gift_for_someone: I18n.t("buy_gift_for_someone"),
          deliver_date: I18n.t("deliver_date"),
          delivery_time: I18n.t("delivery_time"),
          add_to_cart: I18n.t("add_to_cart"),
          availability: I18n.t("availability"),
          my_orders: I18n.t("my_orders"),
          my_carts: I18n.t("my_carts"),
          edit_profile: I18n.t("edit_profile"),
          continue_shopping: I18n.t("continue_shopping"),
          buy_credit: I18n.t("buy_credit"),
          share_credit: I18n.t("share_credit"),
          my_wallet: I18n.t("my_wallet"),
          sub_total: I18n.t("sub_total"),
          time: I18n.t("time"),
          delivery_charges: I18n.t("delivery_charges"),
          total: I18n.t("total"),
          delivery_city: I18n.t("delivery_city"),
          quantity: I18n.t("quantity"),
          receive_gift: I18n.t("receive_gift"),
          forward_gift: I18n.t("forward_gift"),
          receive_in_money: I18n.t("receive_in_money"),
          get_app_credit: I18n.t("get_app_credit"),
          you_have_received_following_gift: I18n.t("you_have_received_following_gift"),
          search_gifts: I18n.t("search_gifts"),
          search_here: I18n.t("search_here"),
          in_stock: I18n.t("in_stock"),
          home: I18n.t("home"),
          select_date: I18n.t("select_date"),
          select_time: I18n.t("select_time"),
          go_to_my_cart: I18n.t("go_to_my_cart"),
          item_added: I18n.t("item_added"),
          go_to_my_orders: I18n.t("go_to_my_orders"),
          congratulations: I18n.t("congratulations"),
          order_message: I18n.t("order_message"),
          back: I18n.t("back"),
          my_cart: I18n.t("my_cart"),
          checkout: I18n.t("checkout"),
          my_gifts: I18n.t("my_gifts"),
          search: I18n.t("search"),
          login_in: I18n.t("login_in"),
          login_in_to_your_account: I18n.t("login_in_to_your_account"),
          password: I18n.t("password"),
          login: I18n.t("login"),
          sign_up: I18n.t("sign_up"),
          sign_up_to_create_your_account: I18n.t("sign_up_to_create_your_account"),
          already_have_an_account: I18n.t("already_have_an_account"),
          do_not_have_an_account: I18n.t("do_not_have_an_account"),
          name: I18n.t("name"),
          contact_number: I18n.t("contact_number"),
          confirm_password: I18n.t("confirm_password")
        }
        }

      end

    end
  end
end
