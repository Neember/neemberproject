FactoryGirl.define do

  sequence :last_name do |n|
    "Vu #{n}"
  end

  factory :user do
    email
    password '123123123'
    first_name 'Martin'
    last_name
  end
end
