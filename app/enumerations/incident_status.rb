module Enumerations
  class IncidentStatus < EnumerateIt::Base
    associate_values(
      :open,
      :solved,
      :reopened,
      :analysing,
      :pending,
      :closed
    )
  end
end
