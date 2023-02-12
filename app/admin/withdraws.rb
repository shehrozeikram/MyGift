ActiveAdmin.register Withdraw do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :card_holder_name, :iban_number, :billing_address, :cvc, :expire_date, :total_payment, :user_id, :store_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:card_holder_name, :iban_number, :billing_address, :cvc, :expire_date, :total_payment, :user_id, :store_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
