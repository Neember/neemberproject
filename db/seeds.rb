# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.delete_all
WorkLog.delete_all
Coder.delete_all
Admin.delete_all

puts 'Start seeding admin'

admins_data = [
  { first_name: 'Steven', last_name: 'Yap', email: 'stevenyap@futureworkz.com' },
  { first_name: 'Iker', last_name: 'Tran', email: 'iker@futureworkz.com' },
  { first_name: 'Jack', last_name: 'Huang', email: 'jack@futureworkz.com' },
  { first_name: 'Martin', last_name: 'Vu', email: 'martin@futureworkz.com' }

]

admins_data.each do |admin_data|
  admin = Coder.find_or_initialize_by(admin_data)
  admin.password = '123456789'
  admin.is_admin = true
  admin.save
end

puts 'Admin seeded'
