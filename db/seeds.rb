# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts '=== Start Cleaning Up Database ==='
Client.delete_all
Project.delete_all
User.delete_all
puts '=== Database cleaned ==='

puts '=== Start seeding Dadadee Project ==='

jack = User.create(first_name: 'Jack', last_name: 'Huang', password: '123123123', email: 'jack@example.com')


leon = Client.create({
 title: :mr,
 first_name: 'Leon',
 :last_name => 'Tay',
 :email => 'leon6@example.com',
 :phone => '1234-5869',
 :designation => 'Owner',
 :company_name => 'Fanfill Technology',
 :address => '50 ABC Street Singapore'
})

dadadee = Project.create!({
  name: 'DaDaDee',
  domain: 'DaDaDee.com',
  date_started: '22/8/2013',
  no_of_sprints: 9.8,
  price_per_sprint: 5000,
  quotation_no: 'FD12313KJL',
  client: leon
})

dadadee.coders << jack

puts '=== Dadadee project seeded ==='

puts '=== Start seeding DualRanked Project ==='

james = User.create(first_name: 'James', last_name: 'James', password: '123123123', email: 'james@example.com')

gabriel = Client.create({
 title: :mr,
 first_name: 'Gabriel',
 :last_name => 'Bunner',
 :email => 'gabriel@example.com',
 :phone => '4456-5869',
 :designation => 'Owner',
 :company_name => 'DualRanked',
 :address => '50 DEF Street Malaysia'
})

dual_ranked = Project.create!({
  name: 'DualRanked',
  domain: 'DualRanked.com',
  date_started: '22/01/2014',
  no_of_sprints: 7,
  price_per_sprint: 4000,
  quotation_no: 'FDS123KJL',
  client: gabriel
})

dual_ranked.coders << james

puts '=== DualRanked project seeded ==='

puts '=== Start seeding LunchKaki Project ==='

iker = User.create(first_name: 'Iker', last_name: 'Tran', password: '123123123', email: 'iker@example.com')

melvin = Client.create({
 title: :mr,
 first_name: 'Melvin',
 :last_name => 'Tan',
 :email => 'melvin@example.com',
 :phone => '4456-5869',
 :designation => 'Owner',
 :company_name => 'LunchKaki',
 :address => '50 GHJF Street Malaysia'
})

lunch_kaki = Project.create!({
  name: 'LunchKaki',
  domain: 'LunchKaki.com',
  date_started: '22/01/2014',
  no_of_sprints: 7,
  price_per_sprint: 4000,
  quotation_no: 'LKK12341KKL',
  client: melvin
})

lunch_kaki.coders << iker
puts '=== LunchKaki project seeded ==='

puts '=== Start seeding Our Cleaning Department Project ==='

ivan = User.create(first_name: 'Ivan', last_name: 'Nguyen', password: '123123123', email: 'ivan@example.com')

geraldine = Client.create({
 title: :ms,
 first_name: 'Geraldine',
 :last_name => '-',
 :email => 'geri.gx@example.com',
 :phone => '4456-5869',
 :designation => 'Owner',
 :company_name => 'Our Cleaning Department',
 :address => 'Blk 601, Bedok Reservoir Road, #03-512, S (470601).'
})

ourcleaningdepartment = Project.create!({
  name: 'Our Cleaning Department',
  domain: 'ourcleaningdepartment.com',
  date_started: '18/3/2014',
  no_of_sprints: 7,
  price_per_sprint: 4000,
  quotation_no: 'FWQ1403006a',
  client: geraldine
})

ourcleaningdepartment.coders << ivan
puts '=== Our Cleaning Department project seeded ==='

puts '=== Start seeding Kheng Project ==='


kheng = Client.create({
 title: :ms,
 first_name: 'Kheng',
 :last_name => '-',
 :email => 'Kheng@example.com',
 :phone => '4456-5869',
 :designation => 'Owner',
 :company_name => 'Kheng',
 :address => '25B Jalan Membina #04-122 Singapore 164025'
})

ourcleaningdepartment = Project.create!({
  name: 'Kheng',
  domain: 'kheng.com',
  date_started: '15-May-2014',
  no_of_sprints: 0.5,
  price_per_sprint: 4000,
  quotation_no: 'FWQ1404046B',
  client: kheng
})

puts '=== Kheng seeded ==='

User.create({first_name: 'Steven', last_name: 'Yap', password: '123456789', email: 'stevenyap@example.com', is_admin: true})

