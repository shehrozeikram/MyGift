# == Schema Information
#
# Table name: receive_payments
#
#  id         :bigint           not null, primary key
#  amount     :float
#  date       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#
class ReceivePayment < ApplicationRecord
  belongs_to :store
end
