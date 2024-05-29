class Patients::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @clinic = Clinic.find(params[:clinic_id])
    @patient = Patient.find(params[:patient_id])
    super
  end

  def create
    @clinic = Clinic.find(params[:clinic_id])
    @patient = Patient.find(params[:patient_id])
    generated_password = @patient.birth_date.strftime('%Y%m%d') # 生年月日をYYYYMMDD形式のパスワードに変換
    if @patient.update(email: params[:patient][:email], password: generated_password, password_confirmation: generated_password, my_page: true)
      redirect_to new_patient_session_path, notice: 'Patient registration completed. Please log in.'
    else
      render :new
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:clinic_id, :patient_id])
  end
end
