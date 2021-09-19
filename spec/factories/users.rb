FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Naoki"
    last_name "Ito"
    sequence(:email) {|n| "tester#{n}@example.com" }
    password "testtest"
  end
end
