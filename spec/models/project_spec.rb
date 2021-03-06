require 'rails_helper'

describe Project do
  context 'Validation Fields' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :date_started }
    it { should validate_numericality_of(:no_of_sprints).is_greater_than 0 }
    it { should validate_numericality_of(:price_per_sprint).is_greater_than 0 }
    it { should validate_presence_of :quotation_no }
    it { should validate_presence_of :client_id }
    it { should validate_numericality_of :pivotal_project_id }
    it { should validate_numericality_of(:velocity).is_greater_than 0 }

    let(:project) { build(:project) }

    it 'validation domain name' do
      project.domain = 'aslkdjask'
      expect(project.valid?).to be_falsey
      project.domain = 'google.com'
      expect(project.valid?).to be_truthy
    end
  end

  context 'association' do
    it { should have_and_belong_to_many(:coders) }
    it { should have_many :work_logs }
  end


  describe 'scope project complete date' do
    context 'scope project complete date' do
      before do
        create_list(:project, 3)
        create_list(:project, 2, date_completed: '20/08/2014')
      end

      it 'scope project complete date' do
        expect(Project.not_completed.count).to eq 3
      end
    end
  end


  describe '#assigns_default_values' do
    context 'Project does not have date started' do
      let(:project) { Project.new }

      it 'assigns default values to project' do
        expect(project.date_started).to eq Date.today
      end
    end

    context 'Project has date started' do
      let(:project) { Project.new(date_started: Date.tomorrow) }

      it 'does not assign default values to project' do
        expect(project.date_started).to eq Date.tomorrow
      end
    end
  end

  describe '#view_target_completion' do
    context 'View target completion project' do
      let!(:work_logs) { create_list(:work_log, 2, status: :unworked)}
      let!(:project) { create(:project, date_started: Date.yesterday, no_of_sprints: 10, work_logs: work_logs) }

      it 'based on number of sprints + absences (in day) from the date started' do
        expect(project.target_completion).to eq Date.yesterday + project.no_of_sprints * 14 + 2
      end
    end
  end

  describe '#completed_sprints' do
    let!(:work_logs) { create_list(:work_log, 12, status: :worked)}
    let(:project) { create :project, date_started: 2.weeks.ago, no_of_sprints: 10, work_logs: work_logs }

    it 'calculates number of completed sprints' do
      expect(project.completed_sprints).to eq 1
      expect(project.completed_percentage).to eq 10.0
    end
  end

  describe '#unworked_days' do
    context 'Get absences in days' do
      let!(:work_logs) { create_list(:work_log, 2, status: :unworked)}
      let!(:project) { create(:project, work_logs: work_logs) }

      it 'absences (in day) from the date started' do
        expect(project.unworked_days).to eq 2
      end
    end

    context 'Get absences in days with unworked day is 4 hours' do
      let!(:work_logs) { create_list(:work_log, 2, hours: 2, status: :unworked)}
      let!(:project) { create(:project, work_logs: work_logs) }

      it 'absences in days with unworked day is 4 hours' do
        expect(project.unworked_days).to eq 0.5
      end
    end
  end

  describe '#estimated_completion' do
    context 'View project estimated completion' do
      let(:project) { create(:project, velocity: 7, points_left: 9) }

      it 'return estimated completion day when project do not have date completed' do
        expect(project.estimated_completion).to eq Date.today + 14
      end
    end

    context 'View project estimated completion' do
      let(:project) { create(:project, velocity: 7, points_left: 9, date_completed: Date.today) }

      it 'return 0 when project have date completed' do
        expect(project.estimated_completion).to eq Date.today
      end
    end
  end

  describe '#overruns' do
    context 'View Over Runs' do
      let(:project) { create(:project, velocity: 7, points_left: 30, date_started: Date.today, no_of_sprints: 2) }
      let!(:work_logs) { create_list(:work_log, 5, project: project) }

      it 'View Over Runs when project do not have date completed' do
        expect(project.overruns).to eq 5
      end
    end

    context 'View Over Runs' do
      let(:project) { create(:project, velocity: 7, points_left: 14, date_started: '20/05/2014', no_of_sprints: 1, date_completed: '5/6/2014') }
      let!(:work_logs) { create_list(:work_log, 5, project: project) }

      it 'View Over Runs when project have date completed' do
        expect(project.overruns).to eq 5
      end
    end

    context 'View Over Runs' do
      let(:project) { create(:project, velocity: 7, points_left: 15, date_started: '20/03/2014', no_of_sprints: 10, date_completed: '5/5/2014') }

      it 'View Over Runs when project have date completed but smaller target completion date' do
        expect(project.overruns).to eq 0
      end
    end
  end

  describe '#overrun?' do
    context 'Estimated overrun' do
      let!(:work_logs) { create_list(:work_log, 2)}
      let(:project) { create(:project, date_started: '10/07/2013', no_of_sprints: 10, work_logs: work_logs) }

      it 'Estimated overrun' do
        expect(project.overrun?).to be_truthy
      end
    end

    context 'Really overrun' do
      let!(:work_logs) { create_list(:work_log, 6)}
      let(:project) { create(:project, date_started: '10/03/2014', no_of_sprints: 1, date_completed: '12/08/2014', work_logs: work_logs) }

      it 'Really overrun' do
        expect(project.overrun?).to be_truthy
      end
    end

    context 'Working days after project completed is larger Left Over Days' do
      let!(:work_logs) { create_list(:work_log, 6) }
      let!(:project) { create(:project, velocity: 7, points_left: 15, date_started: '2014-01-22', no_of_sprints: 7, date_completed: '2014-04-23', work_logs: work_logs) }

      it 'Working days after project completed is larger Left Over Days' do
        expect(project.overrun?).to be_truthy
      end
    end
  end

  describe '#client' do
    context 'get client from api' do
      let(:project) { create :project, client_id: 1}
      let(:client) { {id: 1} }

      def do_request
        get :find
      end

      before do
        expect(Client).to receive(:find).with(project.client_id)
        allow(Client).to receive(:find).and_return(client)
      end

      it 'get client from api' do
        expect(project.client).to eq client
      end
    end
  end

  describe '#left_over_days' do
    context 'View Left Over Days' do
      let(:project) { create(:project, velocity: 7, points_left: 15, date_started: '20/03/2014', no_of_sprints: 10, date_completed: '5/5/2014') }

      it 'View Left Over Days' do
        expect(project.left_over_days).to eq 68
      end
    end

    context 'View Left Over Days when project completed and project has a new task' do
      let!(:project) { create(:project, velocity: 7, points_left: 15, date_started: '20/03/2014', no_of_sprints: 10, date_completed: '5/5/2014') }
      let!(:work_log) { create(:work_log, date: Date.today, project_id: project.id) }

      it 'View Left Over Days when project completed and project has a new task' do
        expect(project.left_over_days).to eq 67
      end
    end
  end
end
