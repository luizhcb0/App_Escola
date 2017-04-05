
FactoryGirl.define do
  factory :message do
    text  "Mensagem"
    sender_receiver :classroom_student
    # message_connection
  end
end
