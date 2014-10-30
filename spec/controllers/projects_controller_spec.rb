require 'rails_helper'

describe ProjectsController do
  let(:admin) { create :admin }

  describe 'GET #index' do
    let!(:projects) { create_list(:project, 5) }

    def do_request
      get :index
    end

    context 'Admin logged in' do
      it 'fetches projects and renders template index' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:projects).size).to eq 5
      end
    end

    context 'User logged in' do
      let(:user) { create(:user) }

      it 'redirects to home page, sets alert flash' do
        sign_in user
        do_request

        expect(response).to redirect_to root_path
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end

    it 'renders template new and assigns new project' do
      sign_in admin
      do_request

      expect(response).to render_template :new
      expect(assigns(:project)).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'success' do
      let(:coders) { create_list(:user, 2) }
      let(:project_param) { attributes_for(:project, client_id: 1, notes: 'Lorem Lorem', pivotal_project_id: 9999, date_completed: '20/10/2014',coder_ids: [coders.first.id])}
      let(:project) { Project.first }

      def do_request
        post :create, project: project_param
      end

      it 'creates project(notes, client and coders), redirects to list, sets notice flash' do
        sign_in admin
        do_request

        expect(project.notes).to eq 'Lorem Lorem'
        expect(project.coders.size).to be > 0
        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      let(:project_param) { {name: ''} }

      def do_request
        post :create, project: project_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in admin
        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #edit' do
    let(:project) { create(:project) }

    def do_request
      get :edit, id: project.id
    end

    it 'renders template edit and finds project' do
      sign_in admin
      do_request

      expect(response).to render_template :edit
      expect(assigns(:project)).to_not be_nil
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:coders) { create_list(:user, 2) }
      let(:project_param) { attributes_for(:project, name: 'Neember', coder_ids: [coders.first.id]) }
      let(:project) { create(:project) }

      def do_request
        patch :update, id: project.id, project: project_param
      end

      it 'updates project, redirects to list and sets notice flash' do
        sign_in admin
        do_request

        expect(project.reload.name).to eq 'Neember'
        expect(project.reload.coders.size).to be > 0
        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      let(:project_param) { attributes_for(:project, name: '') }
      let(:project) { create(:project) }

      def do_request
        patch :update, id: project.id, project: project_param
      end

      it 'renders template edit and sets alert flash' do
        sign_in admin
        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'delete #destroy' do
    context 'success' do
      let!(:project) { create(:project) }

      def do_request
        delete :destroy, id: project.id
      end

      it 'deletes project, redirects to list and sets notice flash' do
        sign_in admin
        expect { do_request }.to change(Project, :count).by(-1)

        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

  describe 'get #show' do
    context 'show project detail' do
      let(:project) { create :project }
      def do_request
        get :show, id: project.id
      end

      it 'render template show project detail and finds project' do
        sign_in admin

        do_request

        expect(response).to render_template :show
        expect(assigns(:project)).to_not be_nil
        expect(assigns(:project).work_logs).to be_loaded
        expect(assigns(:project).versions).to be_loaded
      end
    end
  end
end
