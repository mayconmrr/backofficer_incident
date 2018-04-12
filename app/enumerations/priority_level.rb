module Enumerations
  class PriorityLevel < EnumerateIt::Base
  associate_values(
    :low,
    :medium,
    :high,
    :emergency
  )
  end
end
