module Enumerations
  class IncidentEntity < EnumerateIt::Base
    associate_values(
      :contract,
      :customer,
      :backofficer,
      :broker,
      :claim,
      :assistence,
      :other
    )
  end
end

