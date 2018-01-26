admin = TypeUser.first_or_create(id: TypeUser::ADMIN, name: 'ADMIN')
applicant = TypeUser.first_or_create(id: TypeUser::APPLICANT, name: 'APPLICANT')