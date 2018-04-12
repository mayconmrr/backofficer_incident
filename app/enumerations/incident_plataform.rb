module Enumerations
  class IncidentPlataform < EnumerateIt::Base
    associate_values(
      :app,
      :web
    )
  end
end
