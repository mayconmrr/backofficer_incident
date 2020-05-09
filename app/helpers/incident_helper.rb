module IncidentHelper

  def incident_priority(incident)
    priority_level_value = I18n.t("enumerations.enumerations/priority_level.#{incident.priority_level}")
    label_priority_level = return_priority_level_label(incident)
    "<span class='label label-#{label_priority_level}'>#{priority_level_value}</span>"
  end

  def return_priority_level_label(incident)
    case incident.priority_level
      when PriorityLevel::LOW
        'info'
      when PriorityLevel::MEDIUM
        'warning'
      when PriorityLevel::HIGH
        'danger'
      end
  end

  def incident_status(incident)
    status_value = I18n.t("enumerations.enumerations/incident_status.#{incident.status}")
    label_status = return_status_label(incident)
    "<span class='label label-#{label_status}'>#{status_value}</span>"
  end

  def return_status_label(incident)
    case incident.status
      when IncidentStatus::SOLVED
        'success'
      when IncidentStatus::OPEN
        'warning'
      when IncidentStatus::PENDING
        'info'
      when IncidentStatus::CLOSED
        'default'
      when IncidentStatus::REOPENED
        'danger'
      when IncidentStatus::ANALYSING
        'primary'
      end
  end
end
