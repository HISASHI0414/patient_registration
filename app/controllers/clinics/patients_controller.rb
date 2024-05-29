module Clinics
  class PatientsController < ApplicationController
    before_action :authenticate_clinic!  # ログインしているクリニックのみアクセス可能
    before_action :set_clinic  # 現在のクリニックをセット

    def index
      @patients = @clinic.patients  # クリニックに紐づく患者を取得
    end

    def new
      @clinic = current_clinic  # 現在のクリニックをセット
      @patient = @clinic.patients.build  # 新しい患者オブジェクトを生成
    end

    def create
      @clinic = current_clinic  # 現在のクリニックをセット
      @patient = @clinic.patients.build(patient_params)  # フォームからの入力値で患者オブジェクトを生成
      @patient.email = "" # デフォルト値を設定

      # 生年月日をパスワードとして設定
      if @patient.birth_date.present?
        @patient.password = @patient.birth_date.strftime("%Y%m%d")
        @patient.password_confirmation = @patient.password  # パスワード確認もセット
      else
        flash[:alert] = "Birth date is required to set the password."
        render :new and return
      end

      if @patient.save
        Rails.logger.debug "Patient was successfully created: #{@patient.inspect}"
        redirect_to clinics_patient_path(@patient), notice: 'Patient was successfully created.'  # 保存成功時に患者詳細ページへリダイレクト
      else
        Rails.logger.debug "Failed to create patient: #{@patient.errors.full_messages}"
        render :new  # 保存失敗時に新規作成ページを再表示
      end
    end

    def show
      @patient = @clinic.patients.find(params[:id])  # パラメータIDに対応する患者を取得
      qr_code_content = patient_registration_url(@clinic, @patient)  # QRコードの内容を生成
      @qr = RQRCode::QRCode.new(qr_code_content)  # QRコードを生成
    end

    private

    def set_clinic
      @clinic = current_clinic  # 現在のクリニックをセット
    end

    def patient_params
      params.require(:patient).permit(:medical_record_no, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, :gender, :email)  # 許可するパラメータを定義
    end
  end
end
