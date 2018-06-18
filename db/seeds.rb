# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{ name: 'João da Costa' }, { name: 'Eiji Adachi' }, { name: 'Paula Costa' }, 
             { name: 'Antônio Fagundes'}, { name: 'Stenio Garcia'}])
Driver.create([{ user_id: User.first.id }, { user_id: User.second.id }])
Vehicle.create([{ company_id: 'HHT-01', driver_id: Driver.first.id }, {company_id: 'Horch-01', driver_id: Driver.second.id } ])
Location.create([{ vehicle_id: Vehicle.first.id , latitude: '-5.830272', longitude: '-35.201803' },
                {vehicle_id: Vehicle.second.id, latitude: '-5.812057', longitude: '-35.20714' },
                {vehicle_id: Vehicle.second.id, latitude: '-5.812059', longitude: '-35.20714' }])
Itinerary.create([ {driver_id: Driver.first.id, vehicle_id: Vehicle.first.id }, {driver_id: Driver.second.id, vehicle_id: Vehicle.second.id }])
Task.create([ {object: "Caderno sem capas", responsible_name: "Maria" }, { object: "Móvel 10kg", responsible_name: "João"} ])