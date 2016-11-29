
FactoryGirl.define do
  factory :professor do
    person
    login

    trait :stubed do
      association :person
      association :login
    end
  end
end
