FactoryGirl.define do

  sequence :last_name do |n|
    "Vu #{n}"
  end

  factory :user do
    email
    encrypted_password '123123123'
    first_name 'Martin'
    last_name
  end
end
