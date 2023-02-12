ActiveAdmin.register Notification do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :body, :amount, :store_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:body, :amount, :store_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :body
      f.input :amount
      f.input :store_id, as: :select,  collection:  Store.all.collect{|cat| [ cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :body
    column :amount
    column :store_id do |s|
      s.store.id rescue ""
    end
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    actions
  end

end
