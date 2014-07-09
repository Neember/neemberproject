require 'rails_helper'

describe Leave do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :hours }
    it { should validate_presence_of :reason }
  end

  context 'associations' do
    it { should belong_to(:coder).class_name('User') }
  end
end
