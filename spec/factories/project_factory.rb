FactoryGirl.define do

  factory :project do
    name 'DaDaDee'
    domain 'http://dadadee.com'
    no_of_sprints 9.8
    price_per_sprint 5000
    quotation_no 'Lorem ipsum'
    date_started '22/8/2013'
  end
end
