FactoryBot.define do
  with_namespace(:'Us::Ca::LosAngeles::Police::Roster20220820',
    require_prefix: true) do
    factory :entry do
      employee_name do
        letters = ('A'..'Z').to_a
        given_names = [Faker::Name.first_name, letters.sample].join(' ')
        family_name = Faker::Name.last_name
        "#{family_name}, #{given_names}".upcase
      end
      sequence(:serial_no, 21834, &:to_s) # rubocop:disable Style/NumericLiterals
      rank_tile { %w[PO DPTY CHF CAPT CPL DET SGT LT].sample }
      area { %w[NEWT MCD 77TH NE PER RHD HWD CTD].sample }
      sex { %w[MALE FEMALE NONBINARY].sample }
      ethicity do
        %w[HISPANIC FILIPINO BLACK CAUCASIAN ASIAN/PAC AMERIIND OTHER].sample
      end

      # NOTE: This should be the last trait in the list so `reindex` is called
      # after all the other callbacks complete.
      trait :reindex do
        after(:create) do |entry, _evaluator|
          entry.reindex(refresh: true)
        end
      end
    end
  end
end
