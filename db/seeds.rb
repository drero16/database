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

raceDog0=Race.create({name: "Sin definir", description: "Perro"})
raceDog1=Race.create({name: "Akita Inu", description: "Perro"})
raceDog2=Race.create({name: "Alaskan Malamute", description: "Perro"})
raceDog3=Race.create({name: "Beagle", description: "Perro"})
raceDog4=Race.create({name: "Bichon Maltés", description: "Perro"})
raceDog5=Race.create({name: "Bloodhound", description: "Perro"})
raceDog6=Race.create({name: "Border Collie", description: "Perro"})
raceDog7=Race.create({name: "Boxer", description: "Perro"})
raceDog8=Race.create({name: "Bull Terrier", description: "Perro"})
raceDog9=Race.create({name: "Bulldog Francés", description: "Perro"})
raceDog10=Race.create({name: "Bulldog Inglés", description: "Perro"})
raceDog11=Race.create({name: "Caniche", description: "Perro"})
raceDog12=Race.create({name: "Carlino", description: "Perro"})
raceDog13=Race.create({name: "Chihuahua", description: "Perro"})
raceDog14=Race.create({name: "Chow Chow", description: "Perro"})
raceDog15=Race.create({name: "Cocker Americano", description: "Perro"})
raceDog16=Race.create({name: "Cocker Inglés", description: "Perro"})
raceDog17=Race.create({name: "Collie", description: "Perro"})
raceDog18=Race.create({name: "Doberman", description: "Perro"})
raceDog19=Race.create({name: "Dálmata", description: "Perro"})
raceDog20=Race.create({name: "Fox Terrier", description: "Perro"})
raceDog21=Race.create({name: "Golden Retriever", description: "Perro"})
raceDog22=Race.create({name: "Gran Danés", description: "Perro"})
raceDog23=Race.create({name: "Husky Siberiano", description: "Perro"})
raceDog24=Race.create({name: "Labrador Retriever", description: "Perro"})
raceDog25=Race.create({name: "Lahsa Apso", description: "Perro"})
raceDog26=Race.create({name: "Pastor Alemán", description: "Perro"})
raceDog27=Race.create({name: "Pastor Belga", description: "Perro"})
raceDog28=Race.create({name: "Pekinés", description: "Perro"})
raceDog29=Race.create({name: "Pinscher", description: "Perro"})
raceDog30=Race.create({name: "Pit Bull", description: "Perro"})
raceDog31=Race.create({name: "Rottweiler", description: "Perro"})
raceDog32=Race.create({name: "Samoyedo", description: "Perro"})
raceDog33=Race.create({name: "San Bernardo", description: "Perro"})
raceDog34=Race.create({name: "Schnauzer", description: "Perro"})
raceDog35=Race.create({name: "Setter Irlandés", description: "Perro"})
raceDog36=Race.create({name: "Shar Pei", description: "Perro"})
raceDog37=Race.create({name: "Teckel", description: "Perro"})
raceDog38=Race.create({name: "Welsh Corgi", description: "Perro"})
raceDog39=Race.create({name: "Westie", description: "Perro"})
raceDog40=Race.create({name: "Yorkshire Terrier", description: "Perro"})

raceCat0=Race.create({name: "Sin definir", description: "Gato"})
raceCat1=Race.create({name: "American wirehair", description: "Gato"})
raceCat2=Race.create({name: "Angora", description: "Gato"})
raceCat3=Race.create({name: "British Shorthair", description: "Gato"})
raceCat4=Race.create({name: "California Spangled", description: "Gato"})
raceCat5=Race.create({name: "Cymric", description: "Gato"})
raceCat6=Race.create({name: "Foldex", description: "Gato"})
raceCat7=Race.create({name: "Javaneses", description: "Gato"})
raceCat8=Race.create({name: "Khao Manee", description: "Gato"})
raceCat9=Race.create({name: "Montés", description: "Gato"})
raceCat10=Race.create({name: "Nebelung", description: "Gato"})
raceCat11=Race.create({name: "Oriental de pelo largo", description: "Gato"})
raceCat12=Race.create({name: "Rabón japonés", description: "Gato"})
raceCat13=Race.create({name: "Ragamuffin", description: "Gato"})
raceCat14=Race.create({name: "Ragdoll", description: "Gato"})
raceCat15=Race.create({name: "Sin pelo", description: "Gato"})
raceCat16=Race.create({name: "Somalí", description: "Gato"})
raceCat17=Race.create({name: "Tonquinés", description: "Gato"})

raceOther=Race.create({name: "Sin definir", description: "Otro"})
