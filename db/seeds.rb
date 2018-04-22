
#====================== Analyst ======================#
puts 'Creating Analysts...'

Analyst.create(
  name: 'Analista Default',
  email: 'analyst@thinkseg.com',
  password: '123123'
)

puts 'Analyst created.'

#==================== Backofficer ====================#
puts 'Creating Backofficers...'

Backofficer.create(
  name: 'Backofficer Default',
  email: 'backofficer@thinkseg.com',
  password: '123123'
)

puts 'Backofficers created.'

#====================== Incident ======================#
puts 'Creating Incidents...'

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
