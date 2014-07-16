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

  describe '#sync_projects' do
    before { expect(PivotalTracker::Client).to receive(:token=) }

    it 'updates projects velocity' do
      expect { getter.sync_projects }.to change { project.reload.velocity }.from(10).to(15)
    end

    it 'updates projects points left' do
      expect { getter.sync_projects }.to change { project.reload.points_left }.from(0).to(6)
    end
  end
end
