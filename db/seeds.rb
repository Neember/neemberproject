# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Client.destroy_all

10.times do
  Client.create({
    :title => :mr,
    :first_name => "Jack",
    :last_name => "Huang",
    :email => "client1@example.com",
    :phone => "1234-5869",
    :designation => "Owner",
    :company_name => "ABC Company",
    :address => "123 ABC Street"
  })
end
