# Create test applicant user

require 'faker'

applicant_user_type = TypeUser.find(TypeUser::APPLICANT)

brand_app = ApplicationType.find(ApplicationType::BRAND)
patent_app = ApplicationType.find(ApplicationType::PATENT)
copyright_app = ApplicationType.find(ApplicationType::COPYRIGHT)

20.times do |t|
  username = Faker::Internet.unique.user_name
  password = "12345"

  name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone = Faker::PhoneNumber.phone_number
  email = Faker::Internet.unique.email
  position = Faker::Job.title

  user = User.create(username: username, password: password, password_confirmation: password, type_user_id:TypeUser::APPLICANT)
  applicant = Applicant.create(user: user, email: email, name: name, last_name: last_name, phone: phone, position: position)

  applicant.applications << Application.create(application_type: brand_app, status_application_id: StatusApplication::PENDING)
  applicant.applications << Application.create(application_type: patent_app, status_application_id: StatusApplication::PENDING)
  applicant.applications << Application.create(application_type: copyright_app, status_application_id: StatusApplication::PENDING)
  applicant.save!
end
