# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registered_player do
    name 'pischello'
    password 'secret'
    password_confirmation 'secret'
    sequence(:email) {|n| "player#{n}@example.com"}
    sequence(:rfid) { Player.random_rfid }
  end
end
