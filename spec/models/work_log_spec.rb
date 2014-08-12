require 'rails_helper'

describe WorkLog do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :hours }
    it { should validate_presence_of :status }
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :coder }
    it { should validate_numericality_of(:hours).is_greater_than(0) }
    it { should validate_numericality_of(:hours).is_less_than_or_equal_to(8) }
  end

  context 'associations' do
    it { should belong_to :project }
    it { should belong_to :coder }
  end

  context 'validations reason when status is un-worked' do
    let!(:work_log) { build(:work_log, hours: '', status: :unworked, reason: '') }

    it 'validations reason when status is un-worked' do
      expect(work_log.valid?).to eq false
    end
  end

  context 'validations date when coder add hours is larger 8' do
    let!(:work_log) { build(:work_log, hours: 10, status: :worked) }

    it 'validations date when coder add hours is larger 8' do
      expect(work_log.valid?).to eq false
    end
  end
end
