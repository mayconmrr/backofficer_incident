# frozen_string_literal: true

class Incident < ApplicationRecord
  belongs_to :backofficer
  belongs_to :analyst, optional: true
  before_update :solve_params

  validates :title, presence: true, length: { maximum: 50 }
  validates :problem_description, presence: true

  validates :user_email, presence: true, length: { maximum: 255 }, format: { with: Devise.email_regexp }

  has_attached_file :evidence_screen,
                    styles: { large: '1200x800>',
                              medium: '300x300>',
                              thumb: '100x100>' },
                    default_url: 'missing.png'

  validates_attachment_content_type :evidence_screen, content_type: %r{\Aimage/.*\z}

  scope :search, lambda { |term|
    Incident.includes(:backofficer, :analyst)
            .where('lower(title) LIKE ?', "%#{term.downcase}%")
            .where('lower(problem_description) LIKE ?', "%#{term.downcase}%")
  }

  has_enumeration_for :status, with: Status,
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
    if status == Status::SOLVED
      self.solved_at = DateTime.now
      unless analysis_started_at.nil?
        self.analysis_time = TimeDifference.between(solved_at.to_time, created_at.to_time).humanize
      end
    end
  end
end
