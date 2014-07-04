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
    context 'success' do
      let!(:user_param) { attributes_for(:user, email: 'martin@futureworkz.com') }
      def do_request
        post :create, user: user_param
      end
      it 'created a new user' do
        do_request

        expect(response).to redirect_to users_path
        expect(flash[:notice]).to_not be_nil
        expect(User.first.email).to eq 'martin@futureworkz.com'
      end
    end

    context 'Failed' do
      let!(:user_param) { attributes_for(:user, email: '') }
      def do_request
        post :create, user: user_param
      end
      it 'Failed a new user' do
        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end

  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    def do_request
      get :edit, id: user.id
    end

    it 'display edit form' do
      do_request

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:user){ create(:user) }
      def do_request
        patch :update, id: user.id, user: attributes_for(:user, email: 'martin1234@example.com')
      end
      it 'user is created' do
        do_request

        expect(response).to redirect_to users_path
        expect(flash[:notice]).to_not be_nil
        expect(user.reload.email).to eq 'martin1234@example.com'
      end
    end

    context 'failed' do
      let(:user){ create(:user) }
      def do_request
        patch :update, id: user.id, user: attributes_for(:user, email: '')
      end
      it 'failed to create user' do
        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
