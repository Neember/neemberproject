FactoryGirl.define do
  factory :project do
    name 'DaDaDee'
    domain 'http://dadadee.com'
    no_of_sprints 9.8
    price_per_sprint 5000
    quotation_no 'Lorem ipsum'
    date_started '22/8/2013'
    pivotal_project_id 1234
    client_id 2

    after(:create) do |project|
      project.coders << create(:coder)
    end
  end
end
