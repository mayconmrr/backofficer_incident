module IncidentHelper

  def value_for(incident, attribute)
    attribute_value = incident.send(attribute)
    return_label_method = "return_#{attribute}_label"

    label = send(return_label_method, attribute_value)
    value = I18n.t("enumerations.#{attribute}.#{incident.send(attribute)}")
    "<span class='label label-#{label}'>#{value}</span>"
  end

  def return_priority_level_label(attribute_value)
    case attribute_value
      when PriorityLevel::LOW
        'info'
      when PriorityLevel::MEDIUM
        'warning'
      when PriorityLevel::HIGH
        'danger'
      end
  end

  def return_status_label(attribute_value)
    case attribute_value
      when Status::SOLVED
        'success'
      when Status::OPEN
        'warning'
      when Status::PENDING
        'info'
      when Status::CLOSED
        'default'
      when Status::REOPENED
        'danger'
      when Status::ANALYSING
        'primary'
      end
  end

  def responsible_analyst(incident)
    incident.analyst.blank? ? 'Sem atendimento' : incident.analyst.name
  end

  def current_user_actions
    partial = +"incidents/partials/"
    partial <<
      if backofficer_signed_in?
        'backofficer_actions'
      elsif analyst_signed_in?
        'analyst_actions'
      end
  end
end
