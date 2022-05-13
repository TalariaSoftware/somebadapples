FactoryBot.define do
  factory :document do
    incident
    # NOTE: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |document, _evaluator|
        document.reindex(refresh: true)
      end
    end
  end
end
