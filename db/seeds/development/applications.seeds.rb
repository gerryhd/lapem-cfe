require 'faker'

after "development:users" do
  app = Application.create(id: 666, application_type_id: ApplicationType::BRAND, applicant: Applicant.all.sample, status_application_id: StatusApplication::PENDING)

  app.data_general = DataGeneral.create()
  app.address_notification = AddressNotification.create()

  address = AddressData.create(
      zip_code: "973202",
      street: "81-A",
      external_number: "663",
      colony: "Fraccionamiento Fovissste",
      municipality: "Progreso",
      federal_entity: "Yucatán",
      country: Country.find_by(iso: "MX")
  )

  app.data_general.address_data = address
  app.address_notification.address_data = address.dup

  app.data_general.person = Person.create(type_person_id: TypePerson::PHYSICAL_PERSON,
                                          curp: "2801324900",
                                          name: "Luis",
                                          first_last_name: "Hernandez",
                                          second_last_name: "Quijano",
                                          nationality: "Mexicano",
                                          phone: "9993224335",
                                          email: "secret@gerry.mx"
  )

  app.applicable = DistinctiveSign.create(
                                      description: "Venta de motocicletas al 2x1 en menudeo jaja",
                                      first_date_use: DateTime.now.to_date,
                                      not_used: true,
                                      class_sign: 34,
                                      denomination: "OTTO CYCLE",
                                      tags: "no se",
                                      sign_type_id: SignType::COMMERCIAL_NOTICE,
                                      brand_type_id: BrandType::NOMINATIVE
  )

  app.applicable.establishment_location = EstablishmentLocation.create();
  app.applicable.establishment_location.address_data = address.dup

  app.save!
end
