# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    name "MyString"
    subject { FactoryGirl.build(:player, score: 10) }
    user nil
  end
end
