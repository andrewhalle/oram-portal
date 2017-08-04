# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
central = Admin.create
central.first_name = "Neil"
central.last_name = "Grungras"
central.email = "central@admin.com"
central.address = " 2443 Fillmore St #380-6489, San Francisco, CA 94115"
central.phone = " +1-415-2300601"
central.skype = "ngrungras"
central.password = "password"
central.role = 0
central.save

central1 = Admin.create
central1.first_name = "Irina"
central1.last_name = "Kegeles"
central1.email = "central1@admin.com"
central1.address = " 2443 Fillmore St #380-6489, San Francisco, CA 94115"
central1.phone = " +1-415-2300601"
central1.skype = "ikegeles"
central1.password = "password"
central1.role = 0
central1.save

central2 = Admin.create
central2.first_name = "Jamie"
central2.last_name = "Charnock"
central2.email = "central2@admin.com"
central2.address = " 2443 Fillmore St #380-6489, San Francisco, CA 94115"
central2.phone = " +1-415-2300601"
central2.skype = "jcharnock"
central2.password = "password"
central2.role = 0
central2.save

central3 = Admin.create
central3.first_name = "Anna"
central3.last_name = "Lena Hahn"
central3.email = "central3@admin.com"
central3.address = " 2443 Fillmore St #380-6489, San Francisco, CA 94115"
central3.phone = " +1-415-2300601"
central3.skype = "ahahn"
central3.password = "password"
central3.role = 0
central3.save

employee = Admin.create
employee.first_name = "Ian"
employee.last_name = "Jaffe"
employee.email = "employee@admin.com"
employee.address = "123 Berkeley Street, Berkeley, CA, 94709"
employee.phone = "+01-234-567-8910"
employee.skype = "ijaffe"
employee.password = "password"
employee.role = 1
employee.save

employee1 = Admin.create
employee1.first_name = "Luna"
employee1.last_name = "Liboni"
employee1.email = "employee1@admin.com"
employee1.address = "123 Berkeley Street, Berkeley, CA, 94709"
employee1.phone = "+01-234-567-8910"
employee1.skype = "lliboni"
employee1.password = "password"
employee1.role = 1
employee1.save

employee2 = Admin.create
employee2.first_name = "Anja"
employee2.last_name = "Catherine Limon"
employee2.email = "employee2@admin.com"
employee2.address = "123 Berkeley Street, Berkeley, CA, 94709"
employee2.phone = "+01-234-567-8910"
employee2.skype = "alimon"
employee2.password = "password"
employee2.role = 1
employee2.save

employee3 = Admin.create
employee3.first_name = "Gavi"
employee3.last_name = "Barahona"
employee3.email = "employee3@admin.com"
employee3.address = "123 Berkeley Street, Berkeley, CA, 94709"
employee3.phone = "+01-234-567-8910"
employee3.skype = "gbarahona"
employee3.password = "password"
employee3.role = 1
employee3.save

employee4 = Admin.create
employee4.first_name = "Arielle"
employee4.last_name = "Roter"
employee4.email = "employee4@admin.com"
employee4.address = "123 Berkeley Street, Berkeley, CA, 94709"
employee4.phone = "+01-234-567-8910"
employee4.skype = "aroter"
employee4.password = "password"
employee4.role = 1
employee4.save

referrer = User.create()
referrer.first_name = "Piratheeca" 
referrer.last_name = "Vimalarajah"
referrer.email = "referrer@user.com"
referrer.address = "123 Berkeley Street, Berkeley, CA, 94709"
referrer.phone = "+01-234-567-8910"
referrer.skype = "pvimalarajah"
referrer.password = "password"
referrer.role = 0
referrer.save

referrer1 = User.create()
referrer1.first_name = "Christina" 
referrer1.last_name = "Rosalin Peña"
referrer1.email = "referrer1@user.com"
referrer1.address = "123 Berkeley Street, Berkeley, CA, 94709"
referrer1.phone = "+01-234-567-8910"
referrer1.skype = "cpena"
referrer1.password = "password"
referrer1.role = 0
referrer1.save

referrer2 = User.create()
referrer2.first_name = "Maya" 
referrer2.last_name = "Aronoff"
referrer2.email = "referrer2@user.com"
referrer2.address = "123 Berkeley Street, Berkeley, CA, 94709"
referrer2.phone = "+01-234-567-8910"
referrer2.skype = "maronoff"
referrer2.password = "password"
referrer2.role = 0
referrer2.save

referrer3 = User.create()
referrer3.first_name = "Laura" 
referrer3.last_name = "Moses-Lustiger"
referrer3.email = "referrer3@user.com"
referrer3.address = "123 Berkeley Street, Berkeley, CA, 94709"
referrer3.phone = "+01-234-567-8910"
referrer3.skype = "llustiger"
referrer3.password = "password"
referrer3.role = 0
referrer3.save

referrer4 = User.create()
referrer4.first_name = "Morgan" 
referrer4.last_name = "Thomas"
referrer4.email = "referrer4@user.com"
referrer4.address = "123 Berkeley Street, Berkeley, CA, 94709"
referrer4.phone = "+01-234-567-8910"
referrer4.skype = "mthomas"
referrer4.password = "password"
referrer4.role = 0
referrer4.save

client = User.create()
client.first_name = "Andrew" 
client.last_name = "Halle"
client.email = "client@user.com"
client.address = "123 Berkeley Street, Berkeley, CA, 94709"
client.phone = "+01-234-567-8910"
client.skype = "ahalle"
client.password = "password"
client.role = 1
client.save

client1 = User.create()
client1.first_name = "Alice" 
client1.last_name = "Ma"
client1.email = "client1@user.com"
client1.address = "123 Berkeley Street, Berkeley, CA, 94709"
client1.phone = "+01-234-567-8910"
client1.skype = "ama"
client1.password = "password"
client1.role = 1
client1.save

client2 = User.create()
client2.first_name = "Anna" 
client2.last_name = "Leskova"
client2.email = "client2@user.com"
client2.address = "123 Berkeley Street, Berkeley, CA, 94709"
client2.phone = "+01-234-567-8910"
client2.skype = "aleskova"
client2.password = "password"
client2.role = 1
client2.save

client3 = User.create()
client3.first_name = "Shawn" 
client3.last_name = "Shi"
client3.email = "client3@user.com"
client3.address = "123 Berkeley Street, Berkeley, CA, 94709"
client3.phone = "+01-234-567-8910"
client3.skype = "sshi"
client3.password = "password"
client3.role = 1
client3.save

client4 = User.create()
client4.first_name = "Sam" 
client4.last_name = "Terefe"
client4.email = "client4@user.com"
client4.address = "123 Berkeley Street, Berkeley, CA, 94709"
client4.phone = "+01-234-567-8910"
client4.skype = "sterefe"
client4.password = "password"
client4.role = 1
client4.save

o = Ownership.create
o.user = client
employee.ownerships << o

referral = Form.create()
referral.form_type = 2
referral.user_id = 1
referral.first_name = "Test"
referral.last_name = "Referral"
referral.form_json = JSON.generate({"First Name": "Test", "Last Name": "Questionnaire"})
referral.save

e = Event.create
e.user = client
e.admin = central
e.message = "This is some test text!"
e.save

questionnaire = Form.create()
questionnaire.form_type = 3
questionnaire.user_id = 2
questionnaire.first_name = "Test"
questionnaire.last_name = "Questionnaire"
questionnaire.form_json = JSON.generate({"First Name": "Test", "Last Name": "Questionnaire"})
questionnaire.save()
