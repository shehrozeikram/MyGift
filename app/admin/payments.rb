ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :amount, :user_id, :store_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:amount, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do

      f.input :amount
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :store_id, as: :select,  collection:  Store.all.collect{|cat| [cat.store_name, cat.id]}

    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :amount
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :store_id do |s|
      s.store.store_name rescue ""
    end
    actions
  end

end
