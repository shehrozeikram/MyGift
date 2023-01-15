# == Schema Information
#
# Table name: service_providers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
#
# Indexes
#
#  index_service_providers_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe ServiceProvider, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
