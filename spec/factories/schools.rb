
FactoryGirl.define do
  factory :school do
    name  "Escola Teste"
    professor

    trait :stubed do
      association :professor, :stubed
    end
  end
end
