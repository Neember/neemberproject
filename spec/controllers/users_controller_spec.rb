require 'rails_helper'

describe UsersController do
  describe 'get #index' do
    before { create_list(:user, 3) }
    def do_request
      get :index
    end

    it 'fetches all users and render index view' do
      do_request

      expect(assigns(:users).size).to eq 3
      expect(response).to render_template :index
    end
  end

  describe 'get #new' do
    def do_request
      get :new
    end

    it 'renders new template' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let!(:user_param) { attributes_for(:user, email: 'martin@futureworkz.com') }

    def do_request
      post :create, user: user_param
    end

    context 'success' do
      it 'created a new user' do
        do_request

        expect(response).to redirect_to users_path
        expect(flash[:notice]).to_not be_nil
        expect(User.first.email).to eq 'martin@futureworkz.com'
      end
    end
  end
end
