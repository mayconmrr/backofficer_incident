# frozen_string_literal: true

module UserHelper
  def check_user
    if backofficer_signed_in?
      current_backofficer
    else
      current_analyst
    end
  end
end
