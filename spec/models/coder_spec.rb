require 'rails_helper'

describe Coder do
  context 'associations' do
    it { should have_and_belong_to_many :projects }
    it { should have_many :schedules }
  end
end
