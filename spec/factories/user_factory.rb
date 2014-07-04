FactoryGirl.define do

  factory :user do
    email
    encrypted_password '123123123'
    first_name 'Martin'
    last_name 'Vu'
  end
end
