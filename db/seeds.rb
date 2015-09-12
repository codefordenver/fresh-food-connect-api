# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  first: "Code", 
  last: "for Denver", 
  email: "codefordenver@gmail.com", 
  password: "CFDFFC2015", 
  role: :admin, 
  phone: "555.555.5555",
  confirmed_at: Date.today
)

User.create!(
  first: "Donor", 
  last: "1", 
  email: "donor1@nowhere.org", 
  password: "CFDFFC2015", 
  role: :donor, 
  phone: "555.555.5555",
  confirmed_at: Date.today
)

User.create!(
  first: "Cyclist", 
  last: "1", 
  email: "cyclist1@nowhere.org", 
  password: "CFDFFC2015", 
  role: :cyclist, 
  phone: "555.555.5555",
  confirmed_at: Date.today
)

Location.create!(
  address: "1062 Delaware St",
  city: "Denver", 
  state: "CO",
  zipcode: "80204",
  comments: "It's a commerical building",
  extra: "There is a receptionist",
  route_id: 1,
  pickup_date: "2015-09-15"
)

Location.create!(
  address: "1510 Blake St",
  city: "Denver", 
  state: "CO",
  zipcode: "80202",
  comments: "School is in the basement",
  route_id: 4,
  pickup_date: "2015-10-15"
)