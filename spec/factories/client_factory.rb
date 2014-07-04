FactoryGirl.define do
  sequence :email do |n|
    "client#{n}@example.com"
  end

  sequence :first_name do |n|
    "John #{n}"
  end

  factory :client do
    first_name
    last_name 'Paul'
    email
    phone '1234-5869'
    designation 'Owner'
    company_name 'ABC Company'
    address '123 ABC Street'
  end
end
