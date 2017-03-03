FactoryGirl.define do
  factory :report do
    student
    date      Date.today
  end
end
