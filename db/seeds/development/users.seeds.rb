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
    email: Faker::Internet.unique.email
  }

  applicant = Applicant.create(applicant_details)
  applicant.save!
end
