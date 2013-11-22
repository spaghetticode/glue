# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dummy_player do
    rfid { Player.random_rfid }
  end
end
