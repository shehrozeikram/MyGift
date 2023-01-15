ActiveAdmin.register Resturant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :distance, :ratings, :longitude, :latitude, :tag_list , :user_id, attachments: []


  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :distance
      # f.input :service_provider_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :ratings
      f.input :longitude
      f.input :latitude
      f.input :tag_list
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :distance
    column :ratings
    column :longitude
    column :latitude
    column :tag_list
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
