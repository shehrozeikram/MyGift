# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  attachments :text
#  price       :float
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Card < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  has_many :gifts

end
