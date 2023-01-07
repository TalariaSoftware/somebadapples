FactoryBot.define do
  factory :agency do
    name { "#{Faker::Address.city} PD" }
  end
end
