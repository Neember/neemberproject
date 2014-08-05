require 'rails_helper'

describe WorkLogsController do
  let!(:coder) { create :coder }
  let(:project) { create :project, coders: [coder] }

  describe 'GET #index' do
    def do_request
      get :index
    end

    context 'Coder logged in' do
      let!(:work_logs) { create_list(:work_log, 5, project: project, coder: coder) }

      before { expect(controller).to receive :authenticate_user! }

      it 'fetches all unworked date of current user' do
        sign_in coder

        do_request

        expect(response).to render_template :index
        expect(assigns(:work_logs).size).to eq 5
      end
    end

    context 'No user logged' do
      it 'redirects to root, sets alert flash' do
        do_request

        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to_not be_nil
      end
    end

    context 'Admin logged in' do
      let!(:admin) { create :admin }

      before do
        create_list(:work_log, 2, project: project, coder: coder)
        create_list(:work_log, 2, project: project, coder: admin.becomes(Coder))
      end

      def do_request
        get :index
      end

      it 'fetches all unworked date' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:work_logs).size).to eq 4
      end
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end
    it 'renders template new and assigns new work log' do
      sign_in coder

      do_request

      expect(response).to render_template :new
      expect(assigns(:work_log)).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:work_log_param) { attributes_for(:work_log, date: '10/07/2014', hours: 4, status: :worked, reason: 'Lorem', project_id: project.id) }
      let(:work_log) { WorkLog.first }
      def do_request
        post :create, work_log: work_log_param
      end

      it 'creates work log, redirect to list, sets notice flash' do
        sign_in coder

        do_request

        expect(response).to redirect_to work_logs_path
        expect(work_log.reason).to have_content 'Lorem'
        expect(work_log.coder).to eq coder
        expect(flash[:notice]).to_not be_nil
      end
    end
    context 'Failed' do
      let(:work_log_param) { attributes_for(:work_log, date: '', hours: 4, status: :worked, reason: 'Lorem', coder_id: coder.id) }
      let(:work_log) { WorkLog.first }
      def do_request
        post :create, work_log: work_log_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'get #edit' do
    let!(:work_log) { create(:work_log, project: project) }

    def do_request
      get :edit, id: work_log.id
    end

    it 'renders template edit and finds work log' do
      sign_in coder

      do_request

      expect(response).to render_template :edit
      expect(assigns(:work_log)).to_not be_nil
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:work_log_param) { attributes_for(:work_log, hours: 4, date: '10/07/2014', reason: '', status: :worked, project_id: 1)}
      let(:work_log) { create(:work_log) }

      def do_request
        patch :update, id: work_log.id, work_log: work_log_param
      end

      it 'updates work log, redirects to list and sets notice flash' do
        sign_in coder

        do_request

        expect(work_log.reload.hours).to eq 4
        expect(response).to redirect_to work_logs_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      let(:work_log_param) { attributes_for(:work_log, hours: 'Lorem', date: '10/07/2014', reason: '', status: :worked, project_id: 1) }
      let(:work_log) { create(:work_log) }

      def do_request
        patch :update, id: work_log.id, work_log: work_log_param
      end

      it 'renders template edit and sets alert flash' do
        sign_in coder

        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'delete #destroy' do
    let!(:work_log) { create(:work_log, project: project) }

    def do_request
      delete :destroy, id: work_log.id
    end

    it 'deletes work log, redirects to list and sets notice flash' do
      sign_in coder

      do_request

      expect(response).to redirect_to work_logs_path
      expect(flash[:notice]).to_not be_nil
    end
  end
end
