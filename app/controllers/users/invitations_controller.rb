class Users::InvitationsController < Devise::InvitationsController
  before_filter :update_sanitized_params, only: :update

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end
  
  def new
    @curr_admin = current_admin
    super
  end

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :password, :password_confirmation])
  end

  private

  def invite_resource
     role = params[:user][:role]
     resource_class.invite!(invite_params, current_inviter) do |invitable|
        invitable.role = role
        invitable.phase = "Phase 2"
        invitable.save!
     end
  end

end
