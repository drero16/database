# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
r1 = Role.create({name: "Admin", description: "Administrador. "})
r2 = Role.create({name: "Member", description: "Miembro"})
r3 = Role.create({name: "Guest", description: "No registrado"})

u1 = User.create({name: "Carla", email: "carla@carla.cl", password: "123456", password_confirmation: "123456", role_id: r1.id})