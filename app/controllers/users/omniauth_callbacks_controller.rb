class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user = User.find_for_google_oauth2(google_authenticated_data)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = 'You are not allowed to log in.'
      redirect_to root_path
    end
  end

  private
  def google_authenticated_data
    request.env['omniauth.auth']
  end
end
