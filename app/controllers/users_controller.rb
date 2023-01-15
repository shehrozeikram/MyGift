class UsersController < ApplicationController

  def profile

  end

  def edit_profile
  end

  def set_current_locale
    session[:locale] = params[:locale]
    I18n.locale =   session[:locale]
    redirect_to '/'
  end

  def my_orders
    @my_orders = current_web_user.shopping_carts.where(active: true)
  end
end