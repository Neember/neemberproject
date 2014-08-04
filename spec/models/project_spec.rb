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
    it { should have_many :absences }
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
      let!(:absences) { create_list(:absence, 2)}
      let(:project) { create(:project, date_started: Date.yesterday, no_of_sprints: 10, absences: absences) }

      it 'based on number of sprints + absences (in day) from the date started' do
        expect(project.target_completion).to eq Date.yesterday + project.no_of_sprints * 14 + 2
      end
    end
  end

  describe '#unworked_days' do
    context 'Get absences in days' do
      let!(:absences) { create_list(:absence, 2 )}
      let(:project) { create(:project, absences: absences) }

      it 'absences (in day) from the date started' do
        expect(project.unworked_days).to eq 2
      end
    end

    context 'Get absences in days with unworked day is 4 hours' do
      let!(:absences) { create_list(:absence, 2, hours: 2) }
      let(:project) { create(:project, absences: absences) }

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

      it 'View Over Runs when project do not have date completed' do
        expect(project.overruns).to eq 5
      end
    end
    context 'View Over Runs' do
      let(:project) { create(:project, velocity: 7, points_left: 15, date_started: '20/05/2014', no_of_sprints: 1, date_completed: '5/6/2014') }

      it 'View Over Runs when project have date completed' do
        expect(project.overruns).to eq 2
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
    context 'Estimated completion date > Target completion date' do
      let!(:absences) { create_list(:absence, 2)}
      let(:project) { create(:project, date_started: '10/07/2013', no_of_sprints: 10, absences: absences) }
      it 'returns true if estimated completion date > target completion date' do
        expect(project.overrun?).to be_truthy
      end
    end

    context 'Estimated completion date > Target completion date' do
      let!(:absences) { create_list(:absence, 2)}
      let(:project) { create(:project, date_started: Date.today, no_of_sprints: 10, absences: absences) }
      it 'returns false if estimated completion date < target completion date' do
        expect(project.overrun?).to be_falsey
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
    let(:project) { create(:project, velocity: 7, points_left: 15, date_started: '20/03/2014', no_of_sprints: 10, date_completed: '5/5/2014') }

    context 'View Left Over Days' do
      it 'View Left Over Days' do
        expect(project.overruns).to eq -68
      end
    end
  end
end
