# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


SystemConfig.create!([{ name: 'Investment Length', desc: 'the time frame of investment', value: '200.00', status: true},{ name: 'Client percentage', desc: 'the clients percentages', value: '50.00', status: true},{ name: 'Referrer Percentage', desc: 'the referrers percentage', value: '10.00', status: true}])

Role.create!([{name: 'User'},{name: 'Admin'}])

Permission.create!(action: 'manage', subject_class:'all')

User.create!(username: "albert", last_name: "Lawer", other_names: "Albert", password: "albertlawer", password_confirmation: "albertlawer", contact_number: "0209390147", email: "albertlawer@gmail.com", role_id: Role.find_by_name('Admin').id)


#ref_code, referer_code