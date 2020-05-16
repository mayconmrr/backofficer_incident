# frozen_string_literal: true

class IncidentPlataform < EnumerateIt::Base
  associate_values(
    :app,
    :web,
    :both
  )
end
