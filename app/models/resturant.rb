# == Schema Information
#
# Table name: resturants
#
#  id          :bigint           not null, primary key
#  attachments :text
#  distance    :float
#  latitude    :float
#  longitude   :float
#  ratings     :float
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Resturant < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  acts_as_taggable_on :tags

  belongs_to :user
end
