FactoryGirl.define do
  factory :report do
    student
    date      Date.today
    suboptions {|suboptions| [suboptions.association(:suboption)]}
  end
end
