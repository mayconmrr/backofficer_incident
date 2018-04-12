module Enumerations
  class PendingReason < EnumerateIt::Base
  associate_values(
    :supplier_block,
    :information_missing
  )
  end
end
