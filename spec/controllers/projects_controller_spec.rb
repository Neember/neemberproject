require 'rails_helper'

describe ProjectsController do
  describe 'GET #index' do
    let!(:projects) { create_list(:project, 5) }

    def do_request
      get :index
    end

    it 'View Projects List' do
      do_request

      expect(response).to render_template :index
      expect(assigns(:projects).size).to eq 5
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end

    it 'Create project' do
      do_request

      expect(response).to render_template :new
      expect(assigns(:project)).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'success' do
      let(:client) { create(:client) }
      let(:project_param) { attributes_for(:project, client_id: client.id)}

      def do_request
        post :create, project: project_param
      end

      it 'Create new project' do
        do_request

        expect(Project.first.client).to eq client
        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      let(:project_param){ { :name => '' } }
      def do_request
        post :create, project: project_param
      end
      it 'Failed' do
        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #edit' do
    context 'render edit form' do
      let(:project) { create(:project) }
      def do_request
        get :edit, id: project.id
      end
      it 'edit project form' do
        do_request

        expect(response).to render_template :edit
        expect(assigns(:project)).to_not be_nil
      end
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:project_param) { attributes_for(:project, name: 'Neember') }
      let(:project) { create(:project) }
      def do_request
        patch :update, id: project.id, project: project_param
      end
      it 'update project' do
        do_request

        expect(project.reload.name).to eq 'Neember'
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

      it 'failed update project' do
        do_request

        expect(response).to render_template :new
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
      it 'delete project' do
        do_request

        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

end
