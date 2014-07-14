require 'rails_helper'

describe PivotalVelocityGetter do
  let(:getter) { PivotalVelocityGetter.new }
  let!(:project) { create :project, pivotal_project_id: 123456 }
  let(:mock_projects) { [PivotalTracker::Project.new(id: 123456, current_velocity: 15)] }

  describe '#update_velocity' do
    before do
      allow(PivotalTracker::Project).to receive(:all).and_return(mock_projects)
    end

    it 'updates projects velocity' do
      expect { getter.update_velocity }.to change { project.reload.velocity }.from(0).to(15)
    end
  end
end
