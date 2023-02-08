# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  balance    :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Wallet < ApplicationRecord
  belongs_to :user
end
