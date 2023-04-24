FactoryBot.define do
  factory :lapd_headshot do
    file_name do
      letters = ('A'..'Z').to_a
      digits = ('0'..'9').to_a
      given_names = [Faker::Name.first_name, letters.sample].join(' ')
      family_name = Faker::Name.last_name
      serial_number = digits.sample(6).join
      "#{family_name}, #{given_names} - # #{serial_number}".upcase
    end
  end
end
