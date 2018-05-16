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
