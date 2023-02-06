ActiveAdmin.register Gift do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :sender_name, :your_message, :receiver_name, :receiver_phone_number, :claim_gift, :user_id,:card_id, attachments: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:sender_name, :your_message, :receiver_name, :receiver_phone_number, :attachments]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :sender_name
      f.input :receiver_name
      f.input :your_message
      f.input :receiver_phone_number
      f.input :claim_gift
      f.input :card_id, as: :select,  collection:  Card.all.collect{|cat| [cat.title, cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :sender_name
    column :receiver_name
    column :your_message
    column :receiver_phone_number
    column :claim_gift
    column :card_id do |s|
      s.card.title rescue ""
    end
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :attachments do |ad|
      ul do
        ad.attachments.each do |image|
          li do
            image_tag(image.url, width: 100, height: 100) rescue ""
          end
        end
      end
    end
    actions
  end
end
