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
require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
