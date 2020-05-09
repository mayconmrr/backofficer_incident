class Incident < ApplicationRecord
  belongs_to :backofficer
  belongs_to :analyst, optional: true
  before_update :solve_params

  validates :title, presence: true, length: { maximum: 50 }
  validates_presence_of :problem_description

  validates :user_email, presence: true, length: { maximum: 255 }, format: { with: Devise.email_regexp }

  has_attached_file :evidence_screen,
                    styles: { large: '1200x800>',
                              medium: '300x300>',
                              thumb: '100x100>' },
                    default_url: 'missing.png'

  validates_attachment_content_type :evidence_screen, content_type: /\Aimage\/.*\z/

  scope :search, ->(term) {
    (where('lower(title) LIKE ?', "%#{term.downcase}%") +
        where('lower(problem_description) LIKE ?', "%#{term.downcase}%")).uniq
  }

  has_enumeration_for :status, with: IncidentStatus,
                                create_helpers: true, create_scopes: true

  has_enumeration_for :problem_kind, with: ProblemKind,
                                      create_helpers: true, create_scopes: true

  has_enumeration_for :priority_level, with: PriorityLevel,
                                        create_helpers: true, create_scopes: true

  has_enumeration_for :entity, with: IncidentEntity,
                                create_helpers: true, create_scopes: true

  has_enumeration_for :plataform_kind, with: IncidentPlataform,
                                        create_helpers: true, create_scopes: true

  has_enumeration_for :pending_reason, with: PendingReason,
                                        create_helpers: true, create_scopes: true

  private

  def solve_params
    if self.status == IncidentStatus::SOLVED
      self.solved_at = DateTime.now
      unless self.analysis_started_at.nil?
        self.analysis_time = TimeDifference.between(self.solved_at.to_time, self.created_at.to_time).humanize
      end
    end
  end
end
