# frozen_string_literal: true

#====================== Analyst ======================#
Rails.logger.debug 'Creating Analyst...'

analyst = Analyst.new(
  name: 'Analista Default',
  email: 'analyst@company.com',
  password: '123123',
  password_confirmation: '123123'
)

analyst.skip_confirmation!
analyst.save

Rails.logger.debug 'Analyst created.'

#==================== Backofficer ====================#
Rails.logger.debug 'Creating Backofficer...'

backofficer = Backofficer.new(
  name: 'Backofficer Default',
  email: 'backofficer@company.com',
  password: '123123',
  password_confirmation: '123123'
)

backofficer.skip_confirmation!
backofficer.save

Rails.logger.debug 'Backofficer created.'

#====================== Incident ======================#
unless Rails.env.production?
  Rails.logger.debug 'Creating Fake Incidents...'
  25.times do
    incident = Incident.new(
      title: Faker::Movie.quote,
      priority_level: PriorityLevel.list.sample,
      problem_description: Faker::Lorem.paragraph(sentence_count: [1, 2, 3].sample),
      plataform_kind: IncidentPlataform.list.sample,
      user_email: Faker::Internet.email,
      user_name: Faker::Name.name,
      contract_id: rand(10..100),
      backofficer_id: 1
    )
    incident.save!
  end
  Rails.logger.debug 'Incidents created.'
end
