after :type_users do

  # Create test admin user

  admin_user_type = TypeUser.find(TypeUser::ADMIN)

  admin_user = User.create(username: 'admin2018', password: '2018', password_confirmation: '2018', type_user: admin_user_type)

  Administrator.create(user: admin_user)

  
end
