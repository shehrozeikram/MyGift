# == Schema Information
#
# Table name: ads
#
#  id          :bigint           not null, primary key
#  ad_title    :string
#  ad_type     :string
#  attachments :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  product_id  :integer
#
class Ad < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON
end
