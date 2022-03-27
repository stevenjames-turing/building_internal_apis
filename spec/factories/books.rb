FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    genre { Faker::Book.genre }
    summary { Faker::Lorem.paragraph }
    number_sold { Faker::Number.within(range: 1..10) }
    author
  end
end
