class IncidentPlataform < EnumerateIt::Base
  associate_values(
    :app,
    :web,
    :both
  )
end
