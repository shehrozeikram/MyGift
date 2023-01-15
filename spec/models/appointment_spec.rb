# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint           not null, primary key
#  appointment_date    :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_provider_id :bigint           indexed
#  user_id             :bigint           indexed
#
# Indexes
#
#  index_appointments_on_service_provider_id  (service_provider_id)
#  index_appointments_on_user_id              (user_id)
#
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
