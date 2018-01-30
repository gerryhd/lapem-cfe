after :type_users do

  # Create test admin user

  admin_user_type = TypeUser.find(TypeUser::ADMIN)

  admin_user = User.create(username: 'admin2018', password: '2018', password_confirmation: '2018', type_user: admin_user_type)

  Admin.create(user: admin_user)

  # Create test applicant user

  applicant_user_type = TypeUser.find(TypeUser::APPLICANT)

  applicant_user = User.create(username: 'app2018', password: '2018', password_confirmation: '2018', type_user: applicant_user_type)

  Applicant.create(user: applicant_user, email: 'test@cubicode.mx')
end
