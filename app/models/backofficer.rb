class Backofficer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :incidents

  COMPANY_DOMAINS = %w[company.com mycompany.com].freeze
  validates :email, presence: true, if: :domain_check

  private

  def domain_check
    errors.add(:email, :forbidden_email) unless
    COMPANY_DOMAINS.any? { |word| email.end_with?(word) }
  end
end
