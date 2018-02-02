# Create test applicant user

require 'faker'

applicant_user_type = TypeUser.find(TypeUser::APPLICANT)

20.times do |t|
  username = Faker::Internet.unique.user_name
  password = Faker::Internet.password

  name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone = Faker::PhoneNumber.phone_number
  email = Faker::Internet.unique.email
  position = Faker::Job.title
  
  user = User.create(username: username, password: password, password_confirmation: password)
  Applicant.create(user: user, email: email, name: name, last_name: last_name, phone: phone, position: position)
end