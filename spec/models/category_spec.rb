# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  ar_description :text
#  ar_title       :string
#  attachment     :string
#  description    :text
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin_user_id  :integer
#  parent_id      :integer
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
