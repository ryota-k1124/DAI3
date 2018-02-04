# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

n = 1
while n <= 10

  sn = #{n}.to_s
  email = Faker::Internet.email
  password = "password"
  name = "test#{sn}"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: n,
               provider: n
               )

  Instagram.create(
    content: "hoge",
    image: File.open("./app/assets/images/rails.png"),
    user_id: n
  )
  n = n + 1

end