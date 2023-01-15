# == Schema Information
#
# Table name: businesses
#
#  id          :bigint           not null, primary key
#  attachments :text
#  description :string
#  distance    :float
#  latitude    :float
#  longitude   :float
#  ratings     :float
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
FactoryBot.define do
  factory :business do
    
  end
end
