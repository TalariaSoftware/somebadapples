FactoryBot.define do
  factory :post_record do
    sequence(:officer_id)
    officer_name do
      given_names = [Faker::Name.first_name, Faker::Name.first_name].join(' ')
      family_name = Faker::Name.last_name
      "#{family_name}, #{given_names}".upcase
    end
    post_id do
      letters = ('A'..'Z').to_a
      digits = ('0'..'9').to_a

      [
        letters.sample,
        digits.sample,
        digits.sample,
        '-',
        letters.sample,
        digits.sample,
        digits.sample,
      ].join
    end
    agency { "#{Faker::Address.city.upcase} PD" }
    employment_start_date { rand(365 * 50).days.ago.to_date }
    rank { %w[PO DPTY CHF CAPT CPL DET SGT LT].sample }

    # NOTE: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |post_record, _evaluator|
        post_record.reindex(refresh: true)
      end
    end
  end
end
