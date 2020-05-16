# frozen_string_literal: true

class PriorityLevel < EnumerateIt::Base
  associate_values(
    :low,
    :medium,
    :high
  )
end
