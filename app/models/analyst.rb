class Analyst < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :incidents

  THINK_DOMAINS = ["thinkseg.com", "grgcapital.com"]
  validates :email, presence: true, if: :domain_check

  private

  def domain_check
    unless THINK_DOMAINS.any? { |word| email.end_with?(word)}
      errors.add(:email, "You must be a thinkser to login.")
    end
  end

end
