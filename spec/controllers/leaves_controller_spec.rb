require 'rails_helper'

describe LeavesController do
  let!(:coder) { create :coder }
  describe 'GET #index' do
    def do_request
      get :index
    end

    context 'Coder logged in' do
      let!(:leaves) { create_list(:leave, 5, coder: coder) }
      it 'fetches all unworked date of current user' do
        sign_in coder

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 5
      end
    end

    context 'No user logged' do
      it 'redirects to root, sets alert flash' do
        do_request

        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end
      it 'renders template new and assigns new leave' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(assigns(:leave)).to_not be_nil
      end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:leave_param) { attributes_for(:leave, date: '10/07/2014', hours: 4, reason: 'Lorem', coder_id: coder.id) }
      let(:leave) { Leave.first }
      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash' do
        sign_in coder

        do_request

        expect(response).to redirect_to leaves_path
        expect(leave.reason).to have_content 'Lorem'
        expect(flash[:notice]).to_not be_nil
      end
    end
    context 'Failed' do
      let(:leave_param) { attributes_for(:leave, date: '', hours: 4, reason: 'Lorem', coder_id: coder.id) }
      let(:leave) { Leave.first }
      def do_request
        post :create, leave: leave_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
