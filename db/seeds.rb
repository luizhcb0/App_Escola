# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the rails db:seed command (or created alongside
# the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Test seeds: 
Role.create(name: "admin")
Role.create(name: "principal")
 r_p = Role.create(name: "professor")
 r_s = Role.create(name: "student")
Role.create(name: "student_adjacent")

 cat1 = ActivityCategory.create(name: "Category1")
 cat2 = ActivityCategory.create(name: "Category2")

 act1 = Activity.create(name: "Activity1", activity_category: cat1)
 act2 = Activity.create(name: "Activity2", activity_category: cat1)
 act3 = Activity.create(name: "Activity3", activity_category: cat2)

 opt = Option.create(name: "Option", activity: act3, multiple: true, suboptions: [
   s1 = Suboption.create(name: "sub1"),
   s2 = Suboption.create(name: "sub2"),
   s3 = Suboption.create(name: "sub3"),
   s4 = Suboption.create(name: "sub4")
 ])

 opt2 = Option.create(name: "Option3", activity: act2, multiple: false, suboptions: [
   s5 = Suboption.create(name: "sub5"),
   s6 = Suboption.create(name: "sub6")
])
#
 st = Student.create(name: "Estudante", address: "QNL", birthday: "Sat, 14 Jan 2017")
 us_st = User.create(name: "Usuario", phone: "555555", email: "user@gmail.com", password: "123456", role: r_s)
 StudentUser.create(user: us_st, student: st)

 us_pf = User.create(name: "Professor", phone: "555555", email: "prof@gmail.com", password: "123456", role: r_p)
 pf = Professor.create(user: us_pf)
#
# Report.create(student: st, report_options_attributes: [
#   {option: s1, note: "olar"},
#   {option: s3, note: "alow"},
#   {option: s4, note: "cagou"},
#   {option: s2},
#   ])
