
FactoryGirl.define do
  factory :person do
    name  "Diretora"

    trait :complete do
      email "test@gmail.com"
      phone "3562-4588"
    end
  end
end
