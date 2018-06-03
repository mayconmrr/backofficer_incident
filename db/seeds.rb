
#====================== Analyst ======================#
puts 'Creating Analyst...'

analyst = Analyst.new(
  name: 'Analista Default',
  email: 'analyst@thinkseg.com',
  password: '123123',
  password_confirmation: '123123'
)

analyst.skip_confirmation!
analyst.save

puts 'Analyst created.'

#==================== Backofficer ====================#
puts 'Creating Backofficer...'

backofficer = Backofficer.new(
  name: 'Backofficer Default',
  email: 'backofficer@thinkseg.com',
  password: '123123',
  password_confirmation: '123123'
)

backofficer.skip_confirmation!
backofficer.save

puts 'Backofficer created.'

#====================== Incident ======================#
unless Rails.env.production?
  puts 'Creating Fake Incidents...'
  25.times do
    incident = Incident.new(
      title: Faker::Name.title,
      priority_level: Enumerations::PriorityLevel.list.sample,
      problem_description: Faker::Lorem.paragraph([1,2,3].sample),
      plataform_kind: Enumerations::IncidentPlataform.list.sample,
      user_email: Faker::Internet.email,
      user_cpf: rand(12),
      contract_id: rand(10..100),
      backofficer_id: 1
    )
    incident.save!
  end
  puts 'Incidents created.'
end
