=begin
require 'faker'
require 'open-uri'

after "development:applications" do

  nominativa = BrandType.find(BrandType::NOMINATIVE)
  innominada = BrandType.find(BrandType::INNOMINATED)
  tridimensional = BrandType.find(BrandType::THREE_DIMENSIONAL)
  mixta_denominacion_diseño = BrandType.find(BrandType::DENOMINATION_AND_DESIGN)
  mixta_denominacion_tridimensional = BrandType.find(BrandType::DENOMINATION_AND_3D)
  mixta_diseño_forma_tridimensional = BrandType.find(BrandType::DESIGN_AND_3D)
  mixa_denominacion_diseño_tridimensional = BrandType.find(BrandType::MIXED)
  brand_types = [nominativa, innominada, tridimensional, mixta_denominacion_diseño, mixta_denominacion_tridimensional, mixta_diseño_forma_tridimensional, mixa_denominacion_diseño_tridimensional]

  brand = SignType.find(SignType::BRAND)
  commercial_notice = SignType.find(SignType::COMMERCIAL_NOTICE)
  collective_brand = SignType.find(SignType::COLLECTIVE_BRAND)
  commercial_name = SignType.find(SignType::COMMERCIAL_NAME)
  sign_types = [brand, commercial_notice, collective_brand, commercial_name]
  
  brand_apps = Application.where(application_type_id: ApplicationType::BRAND)
  brand_apps.each do |app|
    var = [1,2].sample

    if var == 1
      person = NaturalPerson.create(app.applicant.to_natural_person)
    elsif var == 2
      person = LegalPerson.create(
        date: DateTime.now.to_date,
        denomination: Faker::Company.name,
        rfc: Faker::Bank.swift_bic,
        phone_number: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email
      )
    end

    app.brand = Brand.create(person: person, brand_type: brand_types.sample, sign_type: sign_types.sample)

    download = open(Faker::Company.logo)

    IO.copy_stream(download, "#{Rails.root}/private/proof_files/#{app.brand.id}.png")
    app.proof_files = [Pathname.new("#{Rails.root}/private/proof_files/#{app.brand.id}.png").open]

    app.save!
  end
end

=end