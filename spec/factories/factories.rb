FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@example.com" }
    name { Faker::Name.name }
    password { "password" }

    trait :with_deposit do
      after :create do |user|
        user.deposit.update(amount: 10)
      end
    end
  end

  factory :product do
    sequence(:name) { |n| "product-#{n}" }
    quantity { 3 }
    cost { 5 }
  end
end
