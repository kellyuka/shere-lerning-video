FactoryBot.define do
  factory :comment do
    user
    list
    body { 'body-test'}
  end
end
