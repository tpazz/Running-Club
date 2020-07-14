# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Creating parent accounts
user_parent1 = User.create!(first_name: "Noah", s_email: "anotherparent@running.com", last_name: "Adler", email: "parent@running.com", password: "Random123", password_confirmation: "Random123")
user_parent2 = User.create!(first_name: "Charlie", last_name: "Anderson",email: "parent1@running.com", password: "Random123", password_confirmation: "Random123")
user_parent3 = User.create!(first_name: "Jacob", last_name: "Beckett",email: "parent2@running.com", password: "Random123", password_confirmation: "Random123")
user_parent4 = User.create!(first_name: "Alfie", last_name: "Brady",email: "parent3@running.com", password: "Random123", password_confirmation: "Random123")
user_parent5 = User.create!(first_name: "Ava", last_name: "Avery",email: "parent4@running.com", password: "Random123", password_confirmation: "Random123")

# User Accounts - Administration
user_ms = User.create!(first_name: "Noah", last_name: "Anderson", email: "ms@running.com", password: "Random123", password_confirmation: "Random123")
user_cs = User.create!(first_name: "Davis", last_name: "Beckett",email: "cs@running.com", password: "Random123", password_confirmation: "Random123")
user_wo = User.create!(first_name: "Dixon", last_name: "Brady",email: "wo@running.com", password: "Random123", password_confirmation: "Random123")
user_admin = User.create!(first_name: "Harvey", last_name: "Specter",email: "admin@running.com", password: "Random123", password_confirmation: "Random123")
user_t = User.create!(first_name: "Mike", last_name: "Adler",email: "t@running.com", password: "Random123", password_confirmation: "Random123")
user_volunteer = User.create!(first_name: "Mike", last_name: "Ross", email: "volunteer@running.com", password: "Random123", password_confirmation: "Random123")
user_run_leader = User.create!(first_name: "Kirito", last_name: "Adler", email: "runleader@running.com", password: "Random123", password_confirmation: "Random123")

user_coach_pending1 = User.create!(first_name: "Hannah", last_name: "Avery", email: "coach@running.com", password: "Random123", password_confirmation: "Random123")
user_coach_pending2 = User.create!(first_name: "Andreas", last_name: "Adler", email: "coach2@running.com", password: "Random123", password_confirmation: "Random123")

user_parent_coach = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@running.com", password: "Random123", password_confirmation: "Random123")
user_parent_coach_t = User.create!(first_name: "Barry", last_name: "Allen", email: "barry@running.com", password: "Random123", password_confirmation: "Random123")
user_parent_coach_cs = User.create!(first_name: "Neal", last_name: "Caffrey", email: "neal@running.com", password: "Random123", password_confirmation: "Random123")

# Roles
role_ms = Role.create!(role_name: "Member Secretary") # MS
role_cs = Role.create!(role_name: "Coach Secretary") # CS
role_wo = Role.create!(role_name: "Welfare Officer") # WO
role_admin = Role.create!(role_name: "Head Admin") # Admin
role_t = Role.create!(role_name: "Treasurer") # T
role_parent = Role.create!(role_name: "Parent") # Parent
role_volunteer = Role.create!(role_name: "Volunteer")
role_run_leader = Role.create!(role_name: "Run Leader")

# Adding roles to users
user_ms.roles << role_ms
user_cs.roles << role_cs
user_wo.roles << role_wo
user_admin.roles << role_admin
user_t.roles << role_t
user_parent1.roles << role_parent
user_parent2.roles << role_parent
user_parent3.roles << role_parent
user_parent4.roles << role_parent
user_parent5.roles << role_parent
user_volunteer.roles << role_volunteer
user_run_leader.roles << role_run_leader
user_parent_coach.roles << role_run_leader
user_parent_coach.roles << role_parent
user_parent_coach_t.roles << role_parent
user_parent_coach_t.roles << role_t
user_parent_coach_cs.roles << role_parent
user_parent_coach_cs.roles << role_cs

# Adding children groups
group_blue_girls = Group.create!(group_name: "Blue Girls", group_colour: "#03FF")
group_blue_boys = Group.create!(group_name: "Blue Boys", group_colour: "#4A87E8")
group_red_girls = Group.create!(group_name: "Red Girls", group_colour: "#FF0000")
group_red_boys = Group.create!(group_name: "Red Boys", group_colour: "#990000")
group_purple = Group.create!(group_name: "Purple", group_colour: "#9901FF")

# Creating some parents
parent1 = Parent.create!(user_id: user_parent1.id, address: "Western Bank Sheffield", postcode: "S10 2TN", prime_mobile: "01142222000", home_number: "01142222")
user_parent1.update(parents_id: parent1.id)
parent2 = Parent.create!(user_id: user_parent2.id, address: "Farm Road", postcode: "S2 2TP", prime_mobile: "01142768905")
user_parent2.update(parents_id: parent2.id)
parent3 = Parent.create!(user_id: user_parent3.id, address: "Granville Road", postcode: "S2 2RL", prime_mobile: "01142602600")
user_parent3.update(parents_id: parent3.id)
parent4 = Parent.create!(user_id: user_parent4.id, address: "Rustlings Road", postcode: "S11 7AB", prime_mobile: "01142734599")
user_parent4.update(parents_id: parent4.id)
parent5 = Parent.create!(user_id: user_parent5.id, address: "76 The Moor", postcode: "S1 4PA", prime_mobile: "01142780334")
user_parent5.update(parents_id: parent5.id)
parent6 = Parent.create!(user_id: user_parent_coach.id, address: "76 Kendell Street", postcode: "S1 3TD", prime_mobile: "07700900854")
user_parent_coach.update(parents_id: parent6.id)
parent7 = Parent.create!(user_id: user_parent_coach_t.id, address: "64 Kendell Street", postcode: "S2 8PL", prime_mobile: "07700900326")
user_parent_coach_t.update(parents_id: parent7.id)
parent8 = Parent.create!(user_id: user_parent_coach_cs.id, address: "61 Winchester Rd", postcode: "DG7 2UQ", prime_mobile: "07700900702")
user_parent_coach_cs.update(parents_id: parent8.id)

# Adding extra phone numbers for parents
PhoneNumber.create!(parent_id: parent1.id, phone_number: "07700900235")
PhoneNumber.create!(parent_id: parent2.id, phone_number: "07700900128")
PhoneNumber.create!(parent_id: parent3.id, phone_number: "07700900905")
PhoneNumber.create!(parent_id: parent4.id, phone_number: "07700900864")
PhoneNumber.create!(parent_id: parent5.id, phone_number: "07700900499")
PhoneNumber.create!(parent_id: parent2.id, phone_number: "07700900724")
PhoneNumber.create!(parent_id: parent4.id, phone_number: "07700900681")
PhoneNumber.create!(parent_id: parent3.id, phone_number: "07700900613")
PhoneNumber.create!(parent_id: parent1.id, phone_number: "07700900253")
PhoneNumber.create!(parent_id: parent5.id, phone_number: "07700900227")
PhoneNumber.create!(parent_id: parent5.id, phone_number: "07700900873")
PhoneNumber.create!(parent_id: parent5.id, phone_number: "07700900835")

# Creating some children
child1 = Child.create!(date_of_birth: "2004-03-13", first_name: "Oliver", last_name: "Easton",
  group_id: group_blue_boys.id, parent_id: parent1.id, gender: 1, medical_issues: "Asthma", photo: 2,
  doctor_address: "9 Sunderland St", doctor_name: "Dr Matthew Lambert", doctor_postcode: "S11 8HN")

child2 = Child.create!(date_of_birth: "2005-02-05", first_name: "Harry", last_name: "Adler",
   group_id: group_purple.id, parent_id: parent2.id, gender: 1, photo: 1,
   doctor_address: "5 Lawson Rd", doctor_name: "Dr Harper", doctor_postcode: "S10 5BU")

child5 = Child.create!(date_of_birth: "2004-12-31", first_name: "James", last_name: "Wilson",
  group_id: group_purple.id, parent_id: parent5.id, gender: 1, medical_issues: "diabetes", photo: 1,
  doctor_address: "9 Sunderland St", doctor_name: "Dr Matthew Lambert", doctor_postcode: "S11 8HN")

child3 = Child.create!(date_of_birth: "2007-07-12", first_name: "Jack", last_name: "Hendrix", group_id: group_red_boys.id, parent_id: parent3.id, gender: 1, inactive_days: 6)
child4 = Child.create!(date_of_birth: "2009-08-23", first_name: "George", last_name: "Smith", group_id: group_blue_boys.id, parent_id: parent4.id, gender: 1, photo: 2, inactive_days: 4)
child6 = Child.create!(date_of_birth: "2006-05-23", first_name: "Ashley", last_name: "Jamya", group_id: group_red_girls.id, parent_id: parent1.id, gender: 2, inactive_days: 3)
child7 = Child.create!(date_of_birth: "2008-12-12", first_name: "Garcia", last_name: "Lindsay", group_id: group_blue_girls.id, parent_id: parent3.id, gender: 0, photo: 1, inactive_days: 6)

child8 = Child.create!(date_of_birth: "2007-07-12", first_name: "Chuck", last_name: "Bartowski", group_id: group_blue_boys.id, parent_id: parent8.id, gender: 1, paid: true)
child9 = Child.create!(date_of_birth: "2010-03-18", first_name: "Andy", last_name: "Strucker", group_id: group_red_boys.id, parent_id: parent6.id, gender: 1, paid: true)
child10 = Child.create!(date_of_birth: "2004-10-02", first_name: "Lauren", last_name: "Strucker", group_id: group_red_girls.id, parent_id: parent8.id, gender: 2, paid: true)

# Child without a group
child11 = Child.create!(date_of_birth: "2009-12-05", first_name: "Emily", last_name: "Brinsley", group_id: nil, parent_id: parent4.id, gender: 2, paid: true)
child12 = Child.create!(date_of_birth: "2008-10-10", first_name: "Sophia", last_name: "Blaine", group_id: nil, parent_id: parent3.id, gender: 2)
child13 = Child.create!(date_of_birth: "2007-08-15", first_name: "Grace", last_name: "Bexley", group_id: nil, parent_id: parent4.id, gender: 2, paid: true)
child14 = Child.create!(date_of_birth: "2006-06-20", first_name: "Mia", last_name: "Bailey", group_id: nil, parent_id: parent3.id, gender: 2)

# Adding Emergency Contacts
EmergencyContact.create!(child_id: child1.id, phone: "07700900976", relationship: "Father")
EmergencyContact.create!(child_id: child2.id, phone: "07700900578", relationship: "Mother")
EmergencyContact.create!(child_id: child3.id, phone: "07700900140", relationship: "Aunt")
EmergencyContact.create!(child_id: child4.id, phone: "07700900789", relationship: "Uncle")
EmergencyContact.create!(child_id: child5.id, phone: "07700900494", relationship: "Older Brother")
EmergencyContact.create!(child_id: child6.id, phone: "07700900761", relationship: "Mother")
EmergencyContact.create!(child_id: child7.id, phone: "07700900953", relationship: "Step Mom")
EmergencyContact.create!(child_id: child1.id, phone: "07700900238", relationship: "Mother")
EmergencyContact.create!(child_id: child2.id, phone: "07700900291", relationship: "Step Dad")
EmergencyContact.create!(child_id: child3.id, phone: "07700900228", relationship: "Mother")
EmergencyContact.create!(child_id: child4.id, phone: "07700900976", relationship: "Father")
EmergencyContact.create!(child_id: child5.id, phone: "07700900578", relationship: "Mother")
EmergencyContact.create!(child_id: child6.id, phone: "07700900140", relationship: "Aunt")
EmergencyContact.create!(child_id: child7.id, phone: "07700900789", relationship: "Uncle")
EmergencyContact.create!(child_id: child2.id, phone: "07700900494", relationship: "Older Brother")
EmergencyContact.create!(child_id: child4.id, phone: "07700900761", relationship: "Mother")
EmergencyContact.create!(child_id: child6.id, phone: "07700900953", relationship: "Step Mom")
EmergencyContact.create!(child_id: child3.id, phone: "07700900238", relationship: "Mother")
EmergencyContact.create!(child_id: child5.id, phone: "07700900291", relationship: "Step Dad")
EmergencyContact.create!(child_id: child7.id, phone: "07700900228", relationship: "Mother")

# Adding coach and volunteer
run_leader = Coach.create!(user_id: user_run_leader.id, telephone: "07700900520", appl_status: true)
volunteer = Coach.create!(user_id: user_volunteer.id, telephone: "07700900125", appl_status: true)
pending1 = Coach.create!(user_id: user_coach_pending1.id, telephone: "07700900967")
pending2 = Coach.create!(user_id: user_coach_pending2.id, telephone: "07700900451")
run_leader3 = Coach.create!(user_id: user_parent_coach.id, telephone: "07700900967", appl_status: true)
pending3 = Coach.create!(user_id: user_parent_coach_t.id, telephone: "07700900744")
pending4 = Coach.create!(user_id: user_parent_coach_cs.id, telephone: "07700900696")

# Adding coach to User model
user_run_leader.update(coaches_id: run_leader.id)
user_volunteer.update(coaches_id: volunteer.id)
user_coach_pending1.update(coaches_id: pending1.id)
user_coach_pending2.update(coaches_id: pending2.id)
user_parent_coach.update(coaches_id: run_leader3.id)
user_parent_coach_t.update(coaches_id: pending3.id)
user_parent_coach_cs.update(coaches_id:  pending4.id)

# Adding documents (NONE documents are really there)
Document.create!(title: "dbs", coach_id: run_leader.id, expiration: "2019-05-05")
Document.create!(title: "Self Declaration", coach_id: run_leader.id, expiration: "2019-10-10")
Document.create!(title: "Coach Qualification", coach_id: volunteer.id, expiration: "2020-12-12")
Document.create!(title: "Safety Qualification", coach_id: volunteer.id, expiration: "2021-12-12")

# Schedule 1, all groups
schedule1 = Schedule.create!(start_time: "2019-04-04 18:00:00", location: "HVH", session_type: "Circuit (indoor shoes)", group_id: group_blue_girls.id)
schedule2 = Schedule.create!(start_time: "2019-04-04 18:00:00", location: "HVH", session_type: "Run", group_id: group_blue_boys.id)
schedule3 = Schedule.create!(start_time: "2019-04-04 18:00:00", location: "HVH", session_type: "Run", group_id: group_red_girls.id)
schedule4 = Schedule.create!(start_time: "2019-04-04 18:00:00", location: "HVH", session_type: "Circuit (indoor shoes)", group_id: group_red_boys.id)
schedule5 = Schedule.create!(start_time: "2019-04-04 18:00:00", location: "HVH", session_type: "Run", group_id: group_purple.id)
# Schedule 2, all groups
schedule6 = Schedule.create!(start_time: "2019-07-07 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_blue_girls.id)
schedule7 = Schedule.create!(start_time: "2019-07-07 18:00:00", location: "HVH", session_type: "Circuits (indoor shoes)", group_id: group_blue_boys.id)
schedule8 = Schedule.create!(start_time: "2019-07-07 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_red_girls.id)
schedule9 = Schedule.create!(start_time: "2019-07-07 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_red_boys.id)
schedule10 = Schedule.create!(start_time: "2019-07-07 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_purple.id)
# Schedule 3, some groups
schedule11 = Schedule.create!(start_time: "2019-06-05 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_blue_girls.id)
schedule12 = Schedule.create!(start_time: "2019-06-05 18:00:00", location: "HVH", session_type: "Run", group_id: group_blue_boys.id)
schedule13 = Schedule.create!(start_time: "2019-06-05 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_red_girls.id)
schedule14 = Schedule.create!(start_time: "2019-06-05 18:00:00", location: "HVH", session_type: "Circuits (indoor shoes)", group_id: group_red_boys.id)
# Schedule 4, all groups
schedule15 = Schedule.create!(start_time: "2019-05-25 18:00:00", location: "HVH", session_type: "Run", group_id: group_blue_girls.id)
schedule16 = Schedule.create!(start_time: "2019-05-25 18:00:00", location: "HVH", session_type: "Intervals / Hills", group_id: group_blue_boys.id)
schedule17 = Schedule.create!(start_time: "2019-05-25 18:00:00", location: "HVH", session_type: "Circuits (indoor shoes)", group_id: group_red_girls.id)
schedule18 = Schedule.create!(start_time: "2019-05-25 18:00:00", location: "HVH", session_type: "Run", group_id: group_red_boys.id)
schedule19 = Schedule.create!(start_time: "2019-05-25 18:00:00", location: "HVH", session_type: "Circuits (indoor shoes)", group_id: group_purple.id)


# Injury Record
InjuryRecord.create!(injury: "Sprained ankle", child_id: child1.id, schedule_id: schedule1.id)
InjuryRecord.create!(injury: "Knee injuries", child_id: child1.id, schedule_id: schedule3.id)
InjuryRecord.create!(injury: "Shin Splints", child_id: child3.id, schedule_id: schedule4.id)
InjuryRecord.create!(injury: "Ankle Sprain", child_id: child5.id, schedule_id: schedule5.id)
InjuryRecord.create!(injury: "Shin Splints", child_id: child6.id, schedule_id: schedule1.id)

# Session Helpers
SessionHelper.create!(coach_id: volunteer.id, schedule_id: schedule2.id)
SessionHelper.create!(coach_id: volunteer.id, schedule_id: schedule4.id)
SessionHelper.create!(coach_id: volunteer.id, schedule_id: schedule5.id)
SessionHelper.create!(coach_id: volunteer.id, schedule_id: schedule3.id)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule5.id)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule4.id)

# Run Leader
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule1.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule2.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule3.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule4.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule5.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule6.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule7.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule8.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule9.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule10.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule11.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule12.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule13.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule14.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule15.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader3.id, schedule_id: schedule16.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule17.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule18.id, team_leader: true)
SessionHelper.create!(coach_id: run_leader.id, schedule_id: schedule19.id, team_leader: true)

# Attendance, Schedule 1
Attendance.create!(child_id: child1.id, schedule_id: schedule1.id, attended: 2)
Attendance.create!(child_id: child2.id, schedule_id: schedule1.id, attended: 2)
Attendance.create!(child_id: child3.id, schedule_id: schedule1.id, attended: 2)
Attendance.create!(child_id: child4.id, schedule_id: schedule1.id, attended: 2)
Attendance.create!(child_id: child5.id, schedule_id: schedule1.id, attended: 1)
Attendance.create!(child_id: child6.id, schedule_id: schedule1.id, attended: 1)

# Other attendance
Attendance.create!(child_id: child5.id, schedule_id: schedule2.id, attended: 2)
Attendance.create!(child_id: child4.id, schedule_id: schedule3.id, attended: 2)
Attendance.create!(child_id: child3.id, schedule_id: schedule4.id, attended: 2)
Attendance.create!(child_id: child2.id, schedule_id: schedule5.id, attended: 2)
Attendance.create!(child_id: child1.id, schedule_id: schedule2.id, attended: 1)
Attendance.create!(child_id: child5.id, schedule_id: schedule3.id, attended: 1)
Attendance.create!(child_id: child4.id, schedule_id: schedule4.id, attended: 2)
Attendance.create!(child_id: child3.id, schedule_id: schedule5.id, attended: 2)
Attendance.create!(child_id: child4.id, schedule_id: schedule5.id, attended: 2)
Attendance.create!(child_id: child7.id, schedule_id: schedule4.id, attended: 2)
Attendance.create!(child_id: child6.id, schedule_id: schedule3.id, attended: 1)
Attendance.create!(child_id: child4.id, schedule_id: schedule2.id, attended: 1)

# Events
Event.create!(date: "2019/04/15", name: "Wolf pit", series: true,
  details: "Infant fun race (age 6-9), Junior race (age 10-u16) start 10.30am. Shatton")

Event.create!(date: "2019/04/20", name: "Edale", series: true,
  details: "ages 8+ 10.15am start – fields above Edale village (Register at Village Hall) ")

Event.create!(date: "2019/03/31", name: "Hathersage Junior", series: false,
  details: "From Hathersage Hall Business Centre – Details TBC")
