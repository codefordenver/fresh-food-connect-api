# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  first: "Code", 
  last: "for Denver", 
  email: "codefordenver@gmail.com", 
  password: "CFCFFC2015", 
  role: :admin, 
  phone: "555.555.5555"
)
