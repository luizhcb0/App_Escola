
FactoryGirl.define do
  factory :option do
    name    "Cagou Muito"
    activity
  end
  factory :suboption, class: Option do
    name    "Sub"
    association :parent, factory: :option
  end
end
