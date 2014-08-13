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

coders_data.each do |coder_data|
  coder = Coder.find_or_initialize_by(coder_data)
  coder.password = '123123123'
  coder.save
  coders[coder.first_name.downcase.to_sym] = coder
end

puts 'Coders seeded'

puts 'Start seeding projects'

projects_data = [
  {client_id: 1, name: 'DaDaDee', domain: 'DaDaDee.com',
   date_started: '2013/03/12', no_of_sprints: 9.8,
   price_per_sprint: 5000, quotation_no: 'FD12313KJL', pivotal_project_id: 929074},
  {client_id: 2, name: 'DualRanked', domain: 'DualRanked.com', date_started: '2014/01/22',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'FDS123KJL'},
  {client_id: 3, name: 'LunchKaki', domain: 'LunchKaki.com', date_started: '2014/01/22',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'LKK12341KKL', pivotal_project_id: 1023700},
  {client_id: 4,name: 'Our Cleaning Department', domain: 'ourcleaningdepartment.com', date_started: '2014/03/18',
   no_of_sprints: 7, price_per_sprint: 4000, quotation_no: 'FWQ1403006a'},
  {client_id: 5, name: 'Kheng', domain: 'kheng.com', date_started: '2014/05/14',
   no_of_sprints: 0.5, price_per_sprint: 4000, quotation_no: 'FWQ1404046B'}
]

projects ||= {}

projects_data.each do |project_data|
  project = Project.find_or_initialize_by(project_data)
  project.save
  projects[project_data[:name].downcase.to_sym] = project
end

puts 'Projects seeded'

puts 'Assgin Dadadee to Jack'
projects[:dadadee].coders << coders[:jack] unless projects[:dadadee].coders.include?(coders[:jack])

puts 'Start seeding working logs'
WorkLog.find_or_initialize_by({
  status: :worked,
  date: '2014/07/12',
  hours: 8,
  reason: 'Personal reason leave',
  project: projects[:dadadee],
  coder: coders[:jack]
}).save
puts 'Working logs seeded'

puts 'Start seeding admin'
Admin.first_or_create!({
  first_name: 'Steven',
  last_name: 'Yap',
  email: 'stevenyap@futureworkz.com',
  password: '123456789',

  is_admin: true
})
puts 'Admin seeded'
