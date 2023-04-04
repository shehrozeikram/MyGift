# == Schema Information
#
# Table name: stores
#
#  id                     :bigint           not null, primary key
#  attachments            :text
#  balance                :float
#  contact_number         :string
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  owner_name             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  store_name             :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
# Indexes
#
#  index_stores_on_email                 (email) UNIQUE
#  index_stores_on_reset_password_token  (reset_password_token) UNIQUE
#
class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON
  has_many :payment
  has_many :notifications
  has_many :withdraws
  has_many :receive_payments

  belongs_to :user

  validates :contact_number, :uniqueness => true

end
