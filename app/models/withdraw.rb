# == Schema Information
#
# Table name: withdraws
#
#  id               :bigint           not null, primary key
#  billing_address  :string
#  card_holder_name :string
#  cvc              :string
#  expire_date      :date
#  iban_number      :string
#  is_completed     :boolean          default(FALSE)
#  total_payment    :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :integer
#  user_id          :integer
#
class Withdraw < ApplicationRecord
  belongs_to :user
  belongs_to :store
end
