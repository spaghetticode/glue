# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    name 'pischello'
    sequence(:rfid) { |n| "#{n}#{'0' * (12-n.to_s.size)}" }
  end
end
