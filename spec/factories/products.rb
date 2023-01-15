# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  ar_description :text
#  ar_title       :string
#  attachment     :string
#  attachments    :string
#  description    :text
#  price          :float
#  ratings        :float
#  stock          :integer
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin_user_id  :integer
#  category_id    :integer
#  parent_id      :integer
#  user_id        :integer
#
FactoryBot.define do
  factory :product do
    title { "MyString" }
    parent_id { 1 }
    description { "MyText" }
    ratings { 1.5 }
    category_id { 1 }
    user_id { 1 }
    price { 1.5 }
    stock { 1 }
  end
end
