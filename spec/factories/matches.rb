# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    association :team_a, factory: :team
    association :team_b, factory: :team
  end
end
