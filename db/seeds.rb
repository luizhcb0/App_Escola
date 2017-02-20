# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the rails db:seed command (or created alongside
# the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adm = Role.create(name: "admin")
Role.create(name: "principal")
Role.create(name: "professor")
 f = Role.create(name: "student")
Role.create(name: "student_adjacent")

 a = ActivityCategory.create(name: "Alimentação")
 b = ActivityCategory.create(name: "Diário")
 c = ActivityCategory.create(name: "Administrativo")

 a1 = Activity.create(name: "Lanche", activity_category: a)
 a2 = Activity.create(name: "Bebida", activity_category: a)
 a3 = Activity.create(name: "Almoço", activity_category: a)


 b1 = Activity.create(name: "Fralda", activity_category: b)
 b2 = Activity.create(name: "Banheiro", activity_category: b)
 b3 = Activity.create(name: "Sono", activity_category: b)


 opt = Option.create(name: "Cocô", activity: b1, multiple: false, suboptions: [
   Suboption.create(name: "Cocô mole"),
    Suboption.create(name: "Diarréia"),
    Suboption.create(name: "Normal")
 ])

 opt2 = Option.create(name: "Xixi", activity: b1, multiple: false, suboptions: [
    Suboption.create(name: "Xixi normal"),
    Suboption.create(name: "Escapou xixi")
 ])

 opt3 = Option.create(name: "Cocô", activity: b2, multiple: false, suboptions: [
    Suboption.create(name: "Cocô mole"),
    Suboption.create(name: "Diarréia"),
    Suboption.create(name: "Normal")
 ])

 opt4 = Option.create(name: "Xixi", activity: b2, multiple: false, suboptions: [
    Suboption.create(name: "Xixi normal"),
    Suboption.create(name: "Escapou xixi")
 ])

 opt5 = Option.create(name: "Tempo", activity: b3, multiple: false, suboptions: [
   Suboption.create(name: "10 minutos"),
   Suboption.create(name: "20 minutos"),
   Suboption.create(name: "30 minutos"),
   Suboption.create(name: "40 minutos"),
   Suboption.create(name: "50 minutos"),
   Suboption.create(name: "60 minutos")
])
#
 st = Student.create(name: "João", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "Ramon", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "Euzébio", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "Lídia", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "Joana", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "Mafalda", address: "QNL", birthday: "Sat, 14 Jan 2017")
 st = Student.create(name: "José", address: "QNL", birthday: "Sat, 14 Jan 2017")
 us = User.create(name: "Usuario", phone: "555555", email: "user@gmail.com", password: "123456", role: f)
 StudentUser.create(user: us, student: st)

 User.create(role: adm, name: 'admin', phone: '123123', email: 'admin@gmail.com', password: 'administrator')
