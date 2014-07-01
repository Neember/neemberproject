FactoryGirl.define do
  sequence :email do |n|
    "client#{n}@example.com"
  end

  factory :client do
    first_name 'John'
    last_name 'Paul'
    email
    phone '1234-5869'
    designation 'Owner'
    company_name 'ABC Company'
    address '123 ABC Street'
  end
end
