FactoryBot.define do
  with_namespace(:'Us::Ca::LosAngeles::Police::Headshots20230321',
    require_prefix: true) do
    factory :headshot do
      file_name do
        letters = ('A'..'Z').to_a
        digits = ('0'..'9').to_a
        given_names = [Faker::Name.first_name, letters.sample].join(' ')
        family_name = Faker::Name.last_name
        serial_number = digits.sample(6).join
        "#{family_name}, #{given_names} - # #{serial_number}".upcase
      end

      # NOTE: This should be the last trait in the list so `reindex` is called
      # after all the other callbacks complete.
      trait :reindex do
        after(:create) do |headshot, _evaluator|
          headshot.reindex(refresh: true)
        end
      end
    end
  end
end
