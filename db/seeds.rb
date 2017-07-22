# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
central = Admin.create
central.first_name = "central"
central.last_name = "admin"
central.email = "central@admin.com"
central.password = "password"
central.role = 0
central.save

employee = Admin.create
employee.first_name = "employee"
employee.last_name = "admin"
employee.email = "employee@admin.com"
employee.password = "password"
employee.role = 1
employee.save

referrer = User.create()
referrer.first_name = "referrer" 
referrer.last_name = "user"
referrer.email = "referrer@user.com"
referrer.password = "password"
referrer.role = 0
referrer.save

client = User.create()
client.first_name = "client" 
client.last_name = "user"
client.email = "client@user.com"
client.address = "123 Berkeley Street, Berkeley, CA, 94709"
client.phone = "+01-234-567-8910"
client.skype = "skype_id"
client.password = "password"
client.role = 1
client.save

employee2 = Admin.create
employee2.first_name = "employee2"
employee2.last_name = "admin"
employee2.email = "employee2@admin.com"
employee2.password = "password"
employee2.role = 1
employee2.save

employee3 = Admin.create
employee3.first_name = "employee3"
employee3.last_name = "admin"
employee3.email = "employee3@admin.com"
employee3.password = "password"
employee3.role = 1
employee3.save

o = Ownership.create
o.user = client
employee.ownerships << o

<<<<<<< HEAD
referral = Form.create()
referral.form_type = 2
referral.user_id = 1
referral.first_name = "Test"
referral.last_name = "Referral"
referral.form_json = JSON.generate({"First Name": "Test", "Last Name": "Questionnaire"})
referral.save

e = Event.create
e.user = client
e.message = "This is some test text!"
e.save

questionnaire = Form.create()
questionnaire.form_type = 3
questionnaire.user_id = 2
questionnaire.first_name = "Test"
questionnaire.last_name = "Questionnaire"
questionnaire.form_json = JSON.generate({"First Name": "Test", "Last Name": "Questionnaire"})
questionnaire.save()
