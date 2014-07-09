require 'rails_helper'

describe Schedule do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :hours }
    it { should validate_presence_of :reason }
    it { should validate_presence_of :coder_id }
    it { should validate_presence_of :project_id }
  end

  context 'associations' do
    it { should belong_to(:coder).class_name('User') }
    it { should belong_to :project }
  end
end
