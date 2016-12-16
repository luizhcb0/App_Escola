
FactoryGirl.define do
  factory :user do
    name              "User"
    sequence(:email) { |n| "email#{n}@example.com" }
    password              "12345678"
    password_confirmation "12345678"
    # password_digest <%= BCrypt::Password.create("12345") %>
    role

    trait :fixed do
      email       "email@example.com"
    end
  end
end
