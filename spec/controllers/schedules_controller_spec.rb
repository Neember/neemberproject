require 'rails_helper'

describe SchedulesController do
  let!(:coder) { create :coder }
  let(:project) { create :project, coders: [coder] }


  describe 'GET #index' do
    def do_request
      get :index
    end

    context 'Coder logged in' do
      let!(:schedules) { create_list(:schedule, 5, project: project) }

      before { expect(controller).to receive :authenticate_user! }

      it 'fetches all unworked date of current user' do
        sign_in coder

        do_request

        expect(response).to render_template :index
        expect(assigns(:schedules).size).to eq 5
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
      it 'renders template new and assigns new schedule' do
        sign_in coder

        do_request

        expect(response).to render_template :new
        expect(assigns(:schedule)).to_not be_nil
      end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:schedule_param) { attributes_for(:schedule, date: '10/07/2014', hours: 4, reason: 'Lorem', coder_id: coder.id, project_id: project.id) }
      let(:schedule) { Schedule.first }
      def do_request
        post :create, schedule: schedule_param
      end

      it 'creates schedule, redirect to list, sets notice flash' do
        sign_in coder

        do_request

        expect(response).to redirect_to schedules_path
        expect(schedule.reason).to have_content 'Lorem'
        expect(flash[:notice]).to_not be_nil
      end
    end
    context 'Failed' do
      let(:schedule_param) { attributes_for(:schedule, date: '', hours: 4, reason: 'Lorem', coder_id: coder.id) }
      let(:schedule) { Schedule.first }
      def do_request
        post :create, schedule: schedule_param
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
    let!(:schedule) { create(:schedule, project: project) }

    def do_request
      delete :destroy, id: schedule.id
    end

    it 'deletes schedule, redirects to list and sets notice flash' do
      sign_in coder

      do_request

      expect(response).to redirect_to schedules_path
      expect(flash[:notice]).to_not be_nil
    end
  end
end
