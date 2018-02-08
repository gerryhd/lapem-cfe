after "development:users" do
  Application.all.each do |application|
    possible_statuses = [:pending, :pending, :pending, :revision, :revision, :rejected, :approved]
    application.status = possible_statuses.sample
    application.save!
  end
end