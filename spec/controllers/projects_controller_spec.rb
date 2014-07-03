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
      let(:project_param){ attributes_for(:project)}
      def do_request
        post :create, project: project_param
      end
      it 'Create new project' do
        do_request

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
end
