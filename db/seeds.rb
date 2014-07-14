# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Start seeding coders'

coders = {}

coders_data = [
  { first_name: 'Jack', last_name: 'Huang', email: 'jack@futureworkz.com' },
  { first_name: 'Iker', last_name: 'Tran', email: 'iker@futureworkz.com' },
  { first_name: 'Thang', last_name: 'Vu', email: 'martin@futureworkz.com' },
  { first_name: 'James', last_name: 'La', email: 'james@futureworkz.com' },
  { first_name: 'Ivan', last_name: 'Nguyen', email: 'ivan@futureworkz.com' }
]

coders_data.each do |coder|
  coder = Coder.find_or_initialize_by(coder)
  coder.password = '123123123'
  coder.save
  coders[coder.first_name.downcase.to_sym] = coder
end

puts 'Coders seeded'

puts 'Start seeding clients'

clients_data = [
  {title: :mr, first_name: 'Leon', last_name: 'Tay', email: 'leon@example.com', phone: '1234-5869', designation: 'Owner', company_name: 'Fanfill Technology', address: '50 ABC Street Singapore'},
  {title: :mr, first_name: 'Gabriel', last_name: 'Bunner', email: 'gabriel@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'DualRanked', address: '50 DEF Street Malaysia'},
  {title: :mr, first_name: 'Melvin', last_name: 'Tan', email: 'melvin@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'LunchKaki', address: '50 GHJF Street Malaysia'},
  {title: :ms, first_name: 'Geraldine', last_name: '-', email: 'geri.gx@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'Our Cleaning Department',address: 'Blk 601, Bedok Reservoir Road, #03-512, S (470601).'},
  {title: :ms, first_name: 'Kheng', last_name: '-', email: 'Kheng@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'Kheng', address: '25B Jalan Membina #04-122 Singapore 164025'}
]
clients ||= {}

clients_data.each do |client|
  client = Client.find_or_initialize_by(client)
  client.save
  clients[client.first_name.downcase.to_sym] = client
end

puts 'Clients seeded'

puts 'Start seeding projects'

projects_data = [
  {client: clients[:leon], name: 'DaDaDee', domain: 'DaDaDee.com',
   date_started: '2013/03/12', no_of_sprints: 9.8,
   price_per_sprint: 5000, quotation_no: 'FD12313KJL'},
  {client: clients[:gabriel], name: 'DualRanked', domain: 'DualRanked.com', date_started: '2014/01/22',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'FDS123KJL'},
  {client: clients[:melvin], name: 'LunchKaki', domain: 'LunchKaki.com', date_started: '2014/01/22',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'LKK12341KKL'},
  {client: clients[:geraldine],name: 'Our Cleaning Department', domain: 'ourcleaningdepartment.com', date_started: '2014/03/18',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'FWQ1403006a'},
  {client: clients[:kheng], name: 'Kheng', domain: 'kheng.com', date_started: '2014/05/14',
   no_of_sprints: 0.5, price_per_sprint: 4000, quotation_no: 'FWQ1404046B'
  }
]

projects ||= {}

projects_data.each do |project|
  project = Project.find_or_initialize_by(project)
  project.save
  projects[project.name.downcase.to_sym] = project
end

puts 'Projects seeded'

puts 'Assgin Dadadee to Jack'
projects[:dadadee].coders << coders[:jack] unless projects[:dadadee].coders.include?(coders[:jack])

puts 'Start seeding absence'
Absence.find_or_initialize_by({
  date: '2014/07/12',
  hours: 8,
  reason: 'Personal reason leave',
  project: projects[:dadadee]
}).save
puts 'Absences seeded'

puts 'Start seeding admin'
Admin.first_or_create!({
  first_name: 'Steven',
  last_name: 'Yap',
  email: 'stevenyap@futureworkz.com',
  password: '123456789',

  is_admin: true
})
puts 'Admin seeded'
