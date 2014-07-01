FactoryGirl.define do
  sequence :email do |n|
    "client#{n}@example.com"
  end

  factory :client do
    name 'John Cena'
    email
    phone '1234-5869'
    address '123 ABC Street'
  end
end
