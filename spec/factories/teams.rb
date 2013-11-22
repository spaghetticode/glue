# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "MyString"
    association :player_1, factory: :registered_player
    association :player_2, factory: :dummy_player
  end
end
