# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  amount     :float
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#  user_id    :integer
#
class Notification < ApplicationRecord
end
