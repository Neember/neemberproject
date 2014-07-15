require 'rails_helper'

describe PivotalProjectTracker do
  let(:getter) { PivotalProjectTracker.new }
  let!(:project) { create :project, pivotal_project_id: 123456 }
  let(:mock_projects) { [pivotal_project] }
  let(:mock_stories) {
    [
      PivotalTracker::Story.new(id: 134123123, estimate: 3),
      PivotalTracker::Story.new(id: 134123123, estimate: 1),
      PivotalTracker::Story.new(id: 134123123, estimate: 2),
      PivotalTracker::Story.new(id: 134123123, estimate: -1)
    ]
  }
  let(:pivotal_project) { PivotalTracker::Project.new(id: 123456, current_velocity: 15) }

  before do
    allow(PivotalTracker::Project).to receive(:all).and_return(mock_projects)
    allow(pivotal_project.stories).to receive(:all).with(story_type: :feature, current_state: [:started, :unscheduled]).and_return(mock_stories)

  end

  describe '#update_velocity' do
    it 'updates projects velocity' do
      expect { getter.update_velocity }.to change { project.reload.velocity }.from(0).to(15)
    end
  end

  describe '#update_points_left' do
    it 'update points left' do
      expect { getter.update_points_left }.to change { project.reload.points_left }.from(0).to(6)
    end
  end
end
