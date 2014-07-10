require 'rails_helper'

describe Schedule do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :hours }
    it { should validate_presence_of :reason }
    it { should validate_presence_of :project_id }
    it { should validate_numericality_of(:hours).is_greater_than(0) }
    it { should validate_numericality_of(:hours).is_less_than_or_equal_to(8) }
  end

  context 'associations' do
    it { should belong_to :project }
  end
end
