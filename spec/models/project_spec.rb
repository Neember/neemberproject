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
    it { should belong_to :client }
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
      let(:project) { create(:project, date_started: Date.today, no_of_sprints: 10) }

      it 'View target completion project' do
        expect(project.target_completion).to eq Date.today + project.no_of_sprints*14
      end
    end
  end

  describe '#estimated_completion' do
    context 'View project estimated completion' do
      let(:project) { create(:project, velocity: 7, points_left: 9) }

      it 'View project estimated completion' do
        expect(project.estimated_completion).to eq Date.today + 14
      end
    end
  end

  describe '#overruns' do
    context 'View Over Runs' do
      let(:project) { create(:project, velocity: 7, points_left: 15, date_started: Date.today, no_of_sprints: 1) }

      it 'View Over Runs' do
        expect(project.overruns).to eq 7
      end
    end
  end
end
