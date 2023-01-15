# == Schema Information
#
# Table name: services
#
#  id          :bigint           not null, primary key
#  attachments :text
#  description :string
#  distance    :string
#  latitude    :float
#  longitude   :float
#  ratings     :float
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
require 'rails_helper'

RSpec.describe Service, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
