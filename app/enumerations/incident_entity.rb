# frozen_string_literal: true

class IncidentEntity < EnumerateIt::Base
  associate_values(
    :contract,
    :policy,
    :trips,
    :customer,
    :backofficer,
    :broker,
    :claim,
    :assistence,
    :supplier,
    :other
  )
end
