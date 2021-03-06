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
  latitude: 39.733464,
  longitude: -104.992615,
  comments: "It's a commerical building",
  extra: "There is a receptionist",
  pickup_date: "2015-09-15",
  user: User.first
)

Location.create!(
  address: "1510 Blake St",
  city: "Denver",
  state: "CO",
  zipcode: "80202",
  latitude: 39.7496354,
  longitude: -105.0001058,
  comments: "School is in the basement",
  pickup_date: "2015-10-15",
  user: User.last
)

Donation.create!(
  size: 1,
  comments: "Package on doorstep",
  created_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  updated_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  location_id: 1,
  user_id: 1
)

Donation.create!(
  size: 3,
  comments: "Find package behind fence gate",
  created_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  updated_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  location_id: 2,
  user_id: 2
)

Donation.create!(
  size: 2,
  comments: "Find package behind fence gate",
  created_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  updated_at: "#<DateTime: 2001-02-03T00:00:00+00:00>",
  location_id: 2,
  user_id: 2
)