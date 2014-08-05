FactoryGirl.define do
  factory :work_log do
    date '09/08/2014'
    hours 8
    reason 'Sickly'
    project
    coder
  end
end
