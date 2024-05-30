# == Schema Information
#
# Table name: patients
#
#  id                         :bigint           not null, primary key
#  birth_date                 :date             not null
#  confirmation_token         :string
#  confirmation_token_sent_at :datetime
#  confirmed_at               :datetime
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  first_name                 :string           not null
#  first_name_kana            :string           not null
#  gender                     :string           not null
#  last_name                  :string           not null
#  last_name_kana             :string           not null
#  medical_record_no          :integer          not null
#  my_page                    :boolean          default(FALSE)
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  clinic_id                  :bigint           not null
#
# Indexes
#
#  index_patients_on_clinic_id                        (clinic_id)
#  index_patients_on_confirmation_token               (confirmation_token) UNIQUE
#  index_patients_on_email                            (email) UNIQUE WHERE ((email)::text <> ''::text)
#  index_patients_on_medical_record_no_and_clinic_id  (medical_record_no,clinic_id) UNIQUE
#  index_patients_on_reset_password_token             (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (clinic_id => clinics.id)
#
require "test_helper"

class PatientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
