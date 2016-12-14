
FactoryGirl.define do
  factory :user do
    name              "User"
    email              "email@gmail.com"
    password              "12345678"
    password_confirmation "12345678"
    # password_digest <%= BCrypt::Password.create("12345") %>
    role  1
  end
end
