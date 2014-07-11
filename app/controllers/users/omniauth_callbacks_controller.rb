class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user = User.find_for_google_oauth2(google_authenticated_data)

    flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
    sign_in_and_redirect @user, :event => :authentication
  end

  private
  def google_authenticated_data
    request.env['omniauth.auth']
  end
end
