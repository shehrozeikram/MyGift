# == Schema Information
#
# Table name: ads
#
#  id          :bigint           not null, primary key
#  ad_title    :string
#  ad_type     :string
#  attachments :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  product_id  :integer
#
FactoryBot.define do
  factory :ad do
    ad_title { "MyString" }
    ad_type { "MyString" }
    category_id { 1 }
    product_id { 1 }
  end
end
