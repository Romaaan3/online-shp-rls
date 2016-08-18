# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['root', 'seller', 'client'].each do |role|
  Role.find_or_create_by({name: role})
end

Block.find_or_create_by(name: "Главная страница")
Block.find_or_create_by(name: "Доставка и оплата")
Block.find_or_create_by(name: "Контакты")


User.create(email: "shop@swap.com.by",
 password: "swap.com.by", confirmed_at: Time.now,
 role_id: Role.find_by_name(:seller).id)

Store.find_or_create_by(name: "Интернет-магазин")
