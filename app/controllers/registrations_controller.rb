class RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(_resource)
    # cofirm_email_sent_path
    new_user_confirmation_path
  end
end
