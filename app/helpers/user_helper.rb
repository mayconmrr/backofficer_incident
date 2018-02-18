module UserHelper
  def check_user
    if backofficer_signed_in?
      return current_backofficer
    else
      return current_analyst
    end
  end
end
