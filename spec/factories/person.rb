
FactoryGirl.define do
  factory :person do
    name  "Diretora"
  end

  factory :full_person, parent: :person do
    email "test@gmail.com"
    phone "3562-4588"
  end
end
