# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  address                 :string
#  avatar                  :string
#  confirmation_sent_at    :datetime
#  confirmation_token      :string           indexed
#  confirmed_at            :datetime
#  contact_number          :string
#  current_sign_in_at      :datetime
#  current_sign_in_ip      :string
#  email                   :string           not null, indexed
#  encrypted_password      :string           not null
#  first_name              :string
#  last_name               :string
#  last_sign_in_at         :datetime
#  last_sign_in_ip         :string
#  locale                  :string
#  must_change_password    :boolean          default(FALSE)
#  provider                :string           default("email"), not null, indexed => [uid]
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string           indexed
#  save_location_latitude  :float
#  save_location_longitude :float
#  sign_in_count           :integer          default(0)
#  tokens                  :json             not null
#  uid                     :string           not null, indexed => [provider]
#  unconfirmed_email       :string
#  username                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable
  mount_uploader :avatar,  AvatarUploader

  acts_as_taggable_on :tags
  acts_as_taggable_on :user_types
  has_many :orders
  has_many :transactions
  has_many :rewards
  has_many :payment
  has_many :wallets
  has_many :gifts
  has_many :contacts
  has_many :appointments
  has_many :camels
  # has_many :appointments, through:  :services
  has_many :services
  include DeviseTokenAuth::Concerns::User
  serialize :tokens

  validates :locale,
            inclusion: { in: I18n.available_locales.map(&:to_s), allow_blank: true },
            if: :locale_changed?

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end

  def self.set_locale(items)

    if I18n.locale.to_s == "ar"
      items.each do |pr|
        pr.description = pr.ar_description
        pr.title = pr.ar_title
      end
    end
  end
end
