# frozen_string_literal: true

class PendingReason < EnumerateIt::Base
  associate_values(
    :supplier_block,
    :information_missing
  )
end
