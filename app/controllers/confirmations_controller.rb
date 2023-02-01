class ConfirmationsController < Devise::ConfirmationsController
  private

  # def after_confirmation_path_for(resource_name, resource)
  #   sign_in(resource) # In case you want to sign in the user
  #   your_new_after_confirmation_path
  # end

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
    # render "show"
  end
end
