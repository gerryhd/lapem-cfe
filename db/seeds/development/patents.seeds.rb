require 'faker'

after "development:applications" do
  patent_apps = Application.where(application_type_id: ApplicationType::PATENT)

  patent_apps.each do |app|
    patent = Patent.create(title: Faker::SiliconValley.invention, divulgation_date: DateTime.now.to_date)
    app.patent = patent
    app.save!
  end
end