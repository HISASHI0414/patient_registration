# == Schema Information
#
# Table name: patients
#
#  id                     :bigint           not null, primary key
#  birth_date             :date             not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  first_name_kana        :string           not null
#  gender                 :string           not null
#  last_name              :string           not null
#  last_name_kana         :string           not null
#  medical_record_no      :integer          not null
#  my_page                :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  clinic_id              :bigint           not null
#
# Indexes
#
#  index_patients_on_clinic_id                        (clinic_id)
#  index_patients_on_email                            (email) UNIQUE WHERE ((email)::text <> ''::text)
#  index_patients_on_medical_record_no_and_clinic_id  (medical_record_no,clinic_id) UNIQUE
#  index_patients_on_reset_password_token             (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (clinic_id => clinics.id)
#
class Patient < ApplicationRecord
  belongs_to :clinic

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :medical_record_no, presence: true, uniqueness: { scope: :clinic_id }
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, :gender, presence: true

  # メールアドレスとパスワードのバリデーションを無効化
  validates :email, presence: true, uniqueness: true, allow_blank: true
  validates :password, presence: true, allow_nil: true
end
