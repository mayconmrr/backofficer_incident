module Enumerations
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
end

# module Enumerations
#   class IncidentEntity < EnumerateIt::Base
#     associate_values(
#         contract: 'contrato',
#         customer: 'cliente',
#         backofficer: 'backofficer',
#         broker: 'corretor',
#         claim: 'sinistro',
#         assistence: 'assistência',
#         other: 'outro'
#     )
#   end
# end
