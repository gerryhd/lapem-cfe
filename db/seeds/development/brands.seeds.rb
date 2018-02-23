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
    var = (1..2).sample

    if var == 1
      person = NaturalPerson.create
    elsif var == 2
      person == LegalPerson.create
    end

    app.brand = Brand.create(person: person, brand_type: brand_types.sample, sign_type: sign_types.sample)
  end
end