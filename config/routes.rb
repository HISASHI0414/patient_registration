Rails.application.routes.draw do
  # Devise用のルーティング。各ユーザータイプに対して異なるコントローラを使用。
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :clinics, controllers: {
    sessions: 'clinics/sessions',
    passwords: 'clinics/passwords',
    registrations: 'clinics/registrations'
  }

  devise_for :patients, controllers: {
    sessions: 'patients/sessions',
    passwords: 'patients/passwords',
    registrations: 'patients/registrations'
  }

  # clinics名前空間の中でのpatientsリソースの定義
  namespace :clinics do
    resources :patients do
      collection do
        get 'search'
      end
    end
  end

  # 管理者ログイン後のルート
  authenticated :admin do
    root 'admins/dashboard#index', as: :authenticated_admin_root
  end

  # 歯科医院ログイン後のルート
  authenticated :clinic do
    root 'clinics/patients#index', as: :authenticated_clinic_root
  end

  # 患者ログイン後のルート
  authenticated :patient do
    root 'patients/dashboard#index', as: :authenticated_patient_root
  end

  # 未認証のユーザーのルート
  devise_scope :admin do
    root to: 'admins/sessions#new', as: :unauthenticated_admin_root
  end

  devise_scope :clinic do
    root to: 'clinics/sessions#new', as: :unauthenticated_clinic_root
  end

  devise_scope :patient do
    root to: 'patients/sessions#new', as: :unauthenticated_patient_root
  end

  # アプリケーションのヘルスチェックルート
  get "up" => "rails/health#show", as: :rails_health_check
end
