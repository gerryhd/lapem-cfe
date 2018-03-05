# Create test applicant user

require 'faker'

applicant_user_type = TypeUser.find(TypeUser::APPLICANT)

brand_app = ApplicationType.find(ApplicationType::BRAND)
patent_app = ApplicationType.find(ApplicationType::PATENT)
copyright_app = ApplicationType.find(ApplicationType::COPYRIGHT)

20.times do |t|
  username = Faker::Internet.unique.user_name
  password = "12345"

  user = User.create(username: username, password: password, password_confirmation: password, type_user: applicant_user_type)

  applicant_details = {
    user: user,
    name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.unique.email,
    position: Faker::Job.title,
    nationality: "Mexicano",
    zip_code: Faker::Address.zip_code,
    street: Faker::Address.street_address,
    ext_num: Faker::Address.secondary_address,
    zone_name: Faker::Address.community,
    municipality: Faker::Address.city
  }

  applicant = Applicant.create(applicant_details)

  applicant.applications << Application.create(application_type: brand_app, status_application_id: StatusApplication::PENDING)
  applicant.applications << Application.create(application_type: patent_app, status_application_id: StatusApplication::PENDING)
  applicant.applications << Application.create(application_type: copyright_app, status_application_id: StatusApplication::PENDING)
  applicant.save!
end
