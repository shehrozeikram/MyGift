ActiveAdmin.register Reward do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :send_date, :amount, :user_id, :gift_id, :receiver_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :send_date, :amount, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :send_date
      f.input :amount
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :gift_id, as: :select,  collection:  Gift.all.collect{|cat| [ cat.id]}
      f.input :receiver_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :send_date
    column :amount
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :gift_id do |s|
      s.user.id rescue ""
    end
    column :receiver_id do |s|
      s.user.first_name rescue ""
    end
    actions
  end


end
