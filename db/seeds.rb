# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the rails db:seed command (or created alongside
# the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ---------------------------------------------------------
# General seed:
# ---------------------------------------------------------
# > Roles
r_adm     = Role.create(name: "admin")
r_princ   = Role.create(name: "principal")
r_prof    = Role.create(name: "professor")
r_std     = Role.create(name: "student")
r_std_adj = Role.create(name: "student_adjacent")

# ---------------------------------------------------------
# Vira Ventos - teste seed:
# ---------------------------------------------------------

# > ActivityCategories & Activities & Options
## Alimentação
ac_aliment = ActivityCategory.create(name: "Alimentação")
  # Lanche
  a_lanche = Activity.create(name: "Lanche", activity_category: ac_aliment)
    opt_ = Option.create(name: "Comida", activity: a_lanche, multiple: true, suboptions: [
       Suboption.create(name: "Banana"),
       Suboption.create(name: "Biscoito"),
       Suboption.create(name: "Pão")
    ])
    opt_ = Option.create(name: "Quantidade", activity: a_lanche, multiple: false, suboptions: [
       Suboption.create(name: "Comeu tudo"),
       Suboption.create(name: "Comeu metade"),
       Suboption.create(name: "Comeu pouco"),
       Suboption.create(name: "Recusou"),
       Suboption.create(name: "Repetiu")
    ])
    opt_ = Option.create(name: "Bebida", activity: a_lanche, multiple: false, suboptions: [
      Suboption.create(name: "Nada"),
       Suboption.create(name: "Água"),
       Suboption.create(name: "Leite"),
       Suboption.create(name: "Suco de fruta")
    ])
  # Almoco
  a_almoco = Activity.create(name: "Almoço", activity_category: ac_aliment)
    opt_ = Option.create(name: "Comida", activity: a_almoco, multiple: true, suboptions: [
       Suboption.create(name: "Arroz"),
       Suboption.create(name: "Feijão"),
       Suboption.create(name: "Carne"),
       Suboption.create(name: "Frango"),
       Suboption.create(name: "Peixe"),
       Suboption.create(name: "Macarrão"),
       Suboption.create(name: "Ovo"),
       Suboption.create(name: "Salada")
    ])
    opt_ = Option.create(name: "Quantidade", activity: a_almoco, multiple: false, suboptions: [
      Suboption.create(name: "Comeu tudo"),
      Suboption.create(name: "Comeu metade"),
      Suboption.create(name: "Comeu pouco"),
      Suboption.create(name: "Recusou"),
      Suboption.create(name: "Repetiu")
    ])
    opt_ = Option.create(name: "Bebida", activity: a_almoco, multiple: false, suboptions: [
      Suboption.create(name: "Nada"),
       Suboption.create(name: "Água"),
       Suboption.create(name: "Suco de fruta")
    ])
    opt_ = Option.create(name: "Sobremesa", activity: a_almoco, multiple: false, suboptions: [
      Suboption.create(name: "Fruta"),
       Suboption.create(name: "Gelatina")
    ])
  # Líquido
  a_liquido = Activity.create(name: "Líquido", activity_category: ac_aliment)
    opt_ = Option.create(name: "Bebida", activity: a_liquido, multiple: true, suboptions: [
      Suboption.create(name: "Água"),
       Suboption.create(name: "Suco"),
       Suboption.create(name: "Leite")
    ])
    opt_ = Option.create(name: "Quantidade", activity: a_liquido, multiple: false, suboptions: [
      Suboption.create(name: "Comeu tudo"),
      Suboption.create(name: "Comeu metade"),
      Suboption.create(name: "Comeu pouco"),
      Suboption.create(name: "Recusou"),
      Suboption.create(name: "Repetiu")
    ])

## Diario
ac_diario  = ActivityCategory.create(name: "Diário")
  # Fralda
  a_fralda   = Activity.create(name: "Fralda", activity_category: ac_diario)
    opt_f_coco = Option.create(name: "Cocô", activity: a_fralda, multiple: false, suboptions: [
       Suboption.create(name: "Cocô mole"),
       Suboption.create(name: "Diarréia"),
       Suboption.create(name: "Normal")
    ])

     opt_f_xixi = Option.create(name: "Xixi", activity: a_fralda, multiple: false, suboptions: [
        Suboption.create(name: "Xixi normal"),
        Suboption.create(name: "Escapou xixi")
    ])
  # Banheiro
  a_banheiro = Activity.create(name: "Banheiro", activity_category: ac_diario)
    opt_b_coco = Option.create(name: "Cocô", activity: a_banheiro, multiple: false, suboptions: [
       Suboption.create(name: "Cocô mole"),
       Suboption.create(name: "Diarréia"),
       Suboption.create(name: "Normal")
    ])

    opt_b_xixi = Option.create(name: "Xixi", activity: a_banheiro, multiple: false, suboptions: [
       Suboption.create(name: "Xixi normal"),
       Suboption.create(name: "Escapou xixi")
    ])
  # Sono
  a_sono     = Activity.create(name: "Sono", activity_category: ac_diario)
    opt_tempo = Option.create(name: "Tempo", activity: a_sono, multiple: false, suboptions: [
      Suboption.create(name: "10 minutos"),
      Suboption.create(name: "20 minutos"),
      Suboption.create(name: "30 minutos"),
      Suboption.create(name: "40 minutos"),
      Suboption.create(name: "50 minutos"),
      Suboption.create(name: "60 minutos")
    ])

## Administrativo
ac_oc     = ActivityCategory.create(name: "Ocorrências")
    a_incidente = Activity.create(name: "Incidentes", activity_category: ac_oc)
      opt_ = Option.create(name: "Tipo", activity: a_incidente, multiple: false, suboptions: [
        Suboption.create(name: "Acidente"),
        Suboption.create(name: "Conflito com colega"),
        Suboption.create(name: "Mal comportamento")
      ])
      opt_ = Option.create(name: "Horário", activity: a_incidente, multiple: false, suboptions: [
        Suboption.create(name: "10 minutos"),
        Suboption.create(name: "20 minutos"),
        Suboption.create(name: "30 minutos"),
        Suboption.create(name: "40 minutos"),
        Suboption.create(name: "50 minutos"),
        Suboption.create(name: "60 minutos")
      ])
    a_incidente = Activity.create(name: "Saúde", activity_category: ac_oc)
      opt_ = Option.create(name: "Problema", activity: a_incidente, multiple: false, suboptions: [
        Suboption.create(name: "Febre"),
        Suboption.create(name: "Afecções Gastrointestinais"),
        Suboption.create(name: "Afecções Respiratórias"),
        Suboption.create(name: "Assadura"),
        Suboption.create(name: "Inalação"),
        Suboption.create(name: "Medicação")
      ])

# > Students
st_bea = Student.create(name: "Beatriz Oliveira", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_bea_m = User.create(name: "Mae", phone: "555555", email: "bea@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_bea_m, student: st_bea)
st_cat = Student.create(name: "Catarina Salmito", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_cat_m = User.create(name: "Mae", phone: "555555", email: "cat@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_cat_m, student: st_cat)
st_cec = Student.create(name: "Cecília Fritsche", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_cec_m = User.create(name: "Mae", phone: "555555", email: "cec@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_cec_m, student: st_cec)
st_fre = Student.create(name: "Frederik Lang", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_fre_m = User.create(name: "Mae", phone: "555555", email: "fre@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_fre_m, student: st_fre)
st_gio = Student.create(name: "Giorgio Lima", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_gio_m = User.create(name: "Mae", phone: "555555", email: "gio@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_gio_m, student: st_gio)
st_isa = Student.create(name: "Isabel Siqueira", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_isa_m = User.create(name: "Mae", phone: "555555", email: "isa@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_isa_m, student: st_isa)
st_lun = Student.create(name: "Maria Luna", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_lun_m = User.create(name: "Mae", phone: "555555", email: "lun@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_lun_m, student: st_lun)
st_cru = Student.create(name: "Maria Cruz", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_cru_m = User.create(name: "Mae", phone: "555555", email: "cru@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_cru_m, student: st_cru)
st_tom = Student.create(name: "Tomás Rojas", address: "QNL", birthday: "Sat, 14 Jan 2017")
  us_tom_m = User.create(name: "Gisela Rojas", phone: "555555", email: "tom@gmail.com", password: "123456", role: r_std)
  StudentUser.create(user: us_tom_m, student: st_tom)

# > Classrooms
us_class = User.create(name: "Turma-A", phone: "555555", email: "brunabarroso65@gmail.com", password: "123456", role: r_prof)
class_a = Classroom.create(user: us_class, shift: "manha", students:[
  st_bea, st_cat, st_cec, st_fre, st_gio, st_isa, st_lun, st_cru, st_tom
  ])

# > Professors
  prof_bru = Professor.create(name: "Bruna Barroso", classroom: class_a)


# > Administrator
User.create(role: r_adm, name: 'admin', phone: '123123', email: 'admin@gmail.com', password: 'administrator')
