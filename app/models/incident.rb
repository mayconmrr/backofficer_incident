class Incident < ApplicationRecord
  belongs_to :backofficer
  belongs_to :analyst, optional: true

  validates :title, presence: true, length: { maximum: 40 }
  validates_presence_of :description
  validates_presence_of :user_email

  has_attached_file :evidence_screen, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :evidence_screen, content_type: /\Aimage\/.*\z/


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
    high: 2,
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
