module Enumerations
  class ProblemKind < EnumerateIt::Base
    associate_values(
      :bug_system,
      :user_request,
      :miseu,
      :not_specified,
      :backofficer_mistake
    )
  end
end

