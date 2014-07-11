require 'rails_helper'

describe Users::OmniauthCallbacksController do
  describe '#google_oauth2' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    def do_request
      post :google_oauth2
    end

    it 'authenticates user' do
      expect { do_request }.to change(User, :count).by(1)
      expect(controller.user_signed_in?).to be_truthy
    end
  end
end
