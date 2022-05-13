FactoryBot.define do
  factory :incident do
    # NOTE: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |incident, _evaluator|
        incident.reindex(refresh: true)
      end
    end
  end
end
