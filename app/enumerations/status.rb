class Status < EnumerateIt::Base
  associate_values(
    :open,
    :solved,
    :reopened,
    :analysing,
    :pending,
    :closed
  )
end
