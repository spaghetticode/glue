# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "MyString"
    association :player_1, factory: :player
    association :player_2, factory: :player
  end
end
