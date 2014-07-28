require 'rails_helper'

describe ListHelper do
  describe '#list_edit_button and #list_delete_button' do
    context 'user' do
      let(:user) { create(:user) }
      let(:edit_button) { helper.list_edit_button(user) }
      let(:delete_button) { helper.list_delete_button(user) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_user_path(user.id)
        expect(edit_button).to include 'data-test="edit-user-' + user.id.to_s + '"'
      end

      it 'returns delete button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include user_path(user.id)
        expect(delete_button).to include 'data-test="delete-user-' + user.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this user?"'
      end
    end

    context 'Client' do
      let(:client) { Client.find(2) }
      let(:edit_button) { helper.list_edit_button(client) }
      let(:delete_button) { helper.list_delete_button(client) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_client_path(client.id)
        expect(edit_button).to include 'data-test="edit-client-' + client.id.to_s + '"'
      end

      it 'returns delete button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include client_path(client.id)
        expect(delete_button).to include 'data-test="delete-client-' + client.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this client?"'
      end
    end

    context 'Project' do
      let(:project) { create(:project) }
      let(:edit_button) { helper.list_edit_button(project) }
      let(:delete_button) { helper.list_delete_button(project) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_project_path(project.id)
        expect(edit_button).to include 'data-test="edit-project-' + project.id.to_s + '"'
      end

      it 'returns edit button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include project_path(project.id)
        expect(delete_button).to include 'data-test="delete-project-' + project.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this project?"'
      end
    end
  end
end
