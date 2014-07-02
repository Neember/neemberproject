require 'rails_helper'

describe ClientsController do
  describe 'GET #index' do
    before { create_list(:client, 3) }

    def do_request
      get :index
    end

    it 'fetches all clients and render index view' do
      do_request

      expect(assigns(:clients).size).to be == 3
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    def do_request
      get :new
    end

    it 'renders new template' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:client_param) { attributes_for(:client) }

    def do_request
      post :create, client: client_param
    end

    context 'success' do
      it 'creates a new client' do
        do_request
        expect(response).to redirect_to clients_path
        expect(flash[:notice]).to be == 'New client added successfully'
      end
    end

    context 'failed' do
      let(:client_param) { attributes_for(:client, first_name: '') }

      it 'displays error and renders new template' do
        do_request
        expect(response).to render_template :new
        expect(flash[:alert]).to be == 'Failed to create client'
      end
    end
  end

  describe 'GET #edit' do
    let(:client) { create(:client) }

    def do_request
      get :edit, id: client.id
    end
    it 'display edit form' do
      do_request
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:client) { create(:client, first_name: 'John') }



    context 'success' do
      def do_request
        patch :update, id: client.id, client: attributes_for(:client, first_name: 'Martin')
      end

      it 'updates client, redirect to clients list and sets the flash' do
        do_request

        expect(client.reload.first_name).to be == 'Martin'
        expect(response).to redirect_to clients_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      def do_request
        patch :update, id: client.id, client: attributes_for(:client, first_name: '')
      end

      it 'should not update client and render edit form' do
        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'delete #destroy' do
    context 'success' do
      let(:client){ create(:client)}
      def do_request
        get :destroy, id: client.id
      end
      it 'delete client, redirect to clients list and sets the flash' do
        do_request

        expect(response).to redirect_to clients_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
