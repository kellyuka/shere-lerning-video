FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name }
    channelid { 'UCZf__ehlCEBPop-_sldpBUQ' }
  end
end
