class Analyst < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :incidents

  THINK_DOMAINS = %w[thinkseg.com grgcapital.com bidu.com.br].freeze
  validates :email, presence: true, if: :domain_check

  private

  def domain_check
    unless THINK_DOMAINS.any? { |word| email.end_with?(word) }
      errors.add(:email, :forbidden_email)
    end
  end
end
