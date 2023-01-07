FactoryBot.define do
  factory :officer do
    sequence :post_id do |n|
      "post_#{n}"
    end

    # NOTE: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |officer, _evaluator|
        officer.reindex(refresh: true)
      end
    end
  end
end
