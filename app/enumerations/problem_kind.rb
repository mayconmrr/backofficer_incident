module Enumerations
  class ProblemKind < EnumerateIt::Base
    associate_values(
      :bug_system,
      :user_request,
      :miseu,
      :backofficer_mistake,
      :not_specified
    )
  end
end

