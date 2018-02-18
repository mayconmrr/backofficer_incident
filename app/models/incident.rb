class Incident < ApplicationRecord
  belongs_to :backofficer
  belongs_to :analyst, optional: true

  PROBLEM_KINDS = {
    bug_system: 0,
    user_request: 1,
    miseu: 3,
    not_specified: 4
  }.with_indifferent_access
  enum problem_kind: PROBLEM_KINDS

  PRIORITY_LEVELS = {
    low: 0,
    medium: 1,
    hight: 2,
    emergency: 90
  }.with_indifferent_access
  enum priority_level: PRIORITY_LEVELS

  STATUSES_INCIDENT = {
    open: 0,
    solved: 1,
    reopened: 3,
    analysing: 4,
    closed: 90
  }.with_indifferent_access
  enum status: STATUSES_INCIDENT

end
