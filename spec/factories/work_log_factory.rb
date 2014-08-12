FactoryGirl.define do
  factory :work_log do
    sequence :date do |n|
      "05/08/20#{n}"
    end
    hours 8
    reason 'Sickly'
    project
    coder
  end
end
