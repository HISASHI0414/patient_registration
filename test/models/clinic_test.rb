# == Schema Information
#
# Table name: clinics
#
#  id                     :bigint           not null, primary key
#  clinic_name            :string           not null
#  clinic_tel_no          :string
#  clinic_url             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_clinics_on_email                 (email) UNIQUE
#  index_clinics_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class ClinicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
