# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the rails db:seed command (or created alongside
# the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(name: "admin")
Role.create(name: "principal")
Role.create(name: "professor")
f = Role.create(name: "student")
Role.create(name: "student_adjacent")

a = ActivityCategory.create(name: "Category1")
b = ActivityCategory.create(name: "Category2")

c = Activity.create(name: "Activity1", activity_category: a)
d = Activity.create(name: "Activity2", activity_category: a)
e = Activity.create(name: "Activity3", activity_category: b)

opt = Option.create(name: "Option", activity: e, suboptions: [
  s1 = Option.create(name: "sub1", activity: e),
  s2 = Option.create(name: "sub2", activity: e),
  s3 = Option.create(name: "sub3", activity: e),
  s4 = Option.create(name: "sub4", activity: e)
])

st = Student.create(name: "Estudante", address: "QNL", birthday: "Sat, 14 Jan 2017")
us = User.create(name: "Usuario", phone: "555555", email: "user@gmail.com", password: "123456", role: f)
StudentUser.create(user: us, student: st)

Report.create(student: st, report_options_attributes: [
  {option: s1, note: "olar"},
  {option: s3, note: "alow"},
  {option: s4, note: "cagou"},
  {option: s2},
  ])
