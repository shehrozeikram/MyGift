# == Schema Information
#
# Table name: stores
#
#  id          :bigint           not null, primary key
#  attachments :text
#  balance     :float
#  owner_name  :string
#  store_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Store < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON
  has_many :payment
  has_many :notifications
  has_many :withdraws
end
