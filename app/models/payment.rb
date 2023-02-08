# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#  user_id    :integer
#
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :store
end
