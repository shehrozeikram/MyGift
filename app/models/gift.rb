# == Schema Information
#
# Table name: gifts
#
#  id                    :bigint           not null, primary key
#  attachments           :text
#  claim_gift            :boolean          default(FALSE)
#  receiver_name         :string
#  receiver_phone_number :string
#  sender_name           :string
#  your_message          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  card_id               :integer
#  user_id               :integer
#
class Gift < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  has_many :transactions
  has_many :rewards

  belongs_to :user
  belongs_to :card

  validates :receiver_name, presence: true
  validates :receiver_phone_number, presence: true
  validates :sender_name, presence: true
  validates :your_message, presence: true
  # validates :attachments, presence: true

end
