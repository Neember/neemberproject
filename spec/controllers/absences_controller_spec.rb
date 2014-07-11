require 'rails_helper'

describe AbsencesController do
  let!(:coder) { create :coder }
  let(:project) { create :project, coders: [coder] }


  describe 'GET #index' do
    def do_request
      get :index
    end

    context 'Coder logged in' do
      let!(:absences) { create_list(:absence, 5, project: project) }

      before { expect(controller).to receive :authenticate_user! }

      it 'fetches all unworked date of current user' do
        sign_in coder

        do_request

        expect(response).to render_template :index
        expect(assigns(:absences).size).to eq 5
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
      it 'renders template new and assigns new absence' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(assigns(:absence)).to_not be_nil
      end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:absence_param) { attributes_for(:absence, date: '10/07/2014', hours: 4, reason: 'Lorem', project_id: project.id) }
      let(:absence) { Absence.first }
      def do_request
        post :create, absence: absence_param
      end

      it 'creates absence, redirect to list, sets notice flash' do
        sign_in coder

        do_request

        expect(response).to redirect_to absences_path
        expect(absence.reason).to have_content 'Lorem'
        expect(flash[:notice]).to_not be_nil
      end
    end
    context 'Failed' do
      let(:absence_param) { attributes_for(:absence, date: '', hours: 4, reason: 'Lorem', coder_id: coder.id) }
      let(:absence) { Absence.first }
      def do_request
        post :create, absence: absence_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'delete #destroy' do
    let!(:absence) { create(:absence, project: project) }

    def do_request
      delete :destroy, id: absence.id
    end

    it 'deletes absence, redirects to list and sets notice flash' do
      sign_in coder

      do_request

      expect(response).to redirect_to absences_path
      expect(flash[:notice]).to_not be_nil
    end
  end
end
