# == Schema Information
#
# Table name: rewards
#
#  id          :bigint           not null, primary key
#  amount      :float
#  send_date   :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gift_id     :integer
#  receiver_id :integer
#  user_id     :integer
#
class Reward < ApplicationRecord

  belongs_to :gift
  belongs_to :user

end
