require 'rails_helper'

describe LeavesController do
  describe 'GET #index' do
    let!(:coder) { create :coder }
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
end
