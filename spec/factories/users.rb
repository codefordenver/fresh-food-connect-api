FactoryGirl.define do
  factory :user do
    first { Faker::Name.first_name }
    last { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role :donor

    trait :admin do
      role :admin
    end
  end
end
