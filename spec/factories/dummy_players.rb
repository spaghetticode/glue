# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dummy_player do
    rfid { SecureRandom.base64(8) }
  end
end
