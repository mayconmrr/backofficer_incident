class Incident < ApplicationRecord
  belongs_to :backofficer
  belongs_to :analyst, optional: true
  before_update :solve_params

  validates :title, presence: true, length: { maximum: 40 }
  validates_presence_of :problem_description
  validates_presence_of :user_email

  has_attached_file :evidence_screen, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :evidence_screen, content_type: /\Aimage\/.*\z/

  scope :search, ->(term, page) {
    (where("lower(title) LIKE ?", "%#{term.downcase}%") + where("lower(problem_description) LIKE ?", "%#{term.downcase}%"))
  }

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
    pending: 5,
    closed: 90
  }.with_indifferent_access
  enum status: STATUSES_INCIDENT

  ENTITY = {
      contract: 0,
      customer: 1,
      backofficer: 2,
      broker: 3,
      claim: 4,
      assistence: 5,
      other: 90
  }.with_indifferent_access
  enum entity: ENTITY

  PLATAFORM = {
    app: 0,
    web: 1
  }.with_indifferent_access
  enum plataform_kind: PLATAFORM

  PENDING = {
      supplier_block: 0,
      information_missing: 1
  }.with_indifferent_access
  enum pending_reason: PENDING

  private

  def solve_params
    if self.status == 'solved'
      self.solved_at = DateTime.now
      unless self.analysis_started_at.nil?
        self.analysis_time = TimeDifference.between(self.solved_at.to_time, self.created_at.to_time).humanize
      end
    end
  end
end
