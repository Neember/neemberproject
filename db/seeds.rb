# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Client.destroy_all
Project.destroy_all
User.destroy_all

10.times do |n|
  client = Client.create({
    :title => :mr,
    :first_name => "Example #{n}",
    :last_name => 'Client',
    :email => "client.#{n}@example.com",
    :phone => "1234-5869",
    :designation => "Owner",
    :company_name => "ABC Company",
    :address => "123 ABC Street"
  })
  puts 'Completed create client'
  user = User.create({
                :first_name => "Martin",
                :last_name => "Vu",
                :password => "123123123",
                :email => "user.#{n}@futureworkz.com"
              })
  puts 'Completed create user'
  Project.create({
    :name => "DaDaDee",
    :domain => "DaDaDee.com",
    :date_started => "22/8/2013",
    :no_of_sprints => 9.8,
    :price_per_sprint => 5000,
    :quotation_no => "Lorem ipsum",
    :client => client,
    :user => user,
  })
  puts 'Completed create project'
end

client = Client.first
project = Project.first

client.projects << project
