
FactoryGirl.define do
  factory :message do
    text  "Mensagem"
    sender_receiver :classroom_student

    classrooms {|classrooms| [classrooms.association(:classroom)]}
    students {|students| [students.association(:student)]}
  end
end
