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
    partial = +"incidents/partials/#{current_action_name}/"
    partial <<
      if backofficer_signed_in?
        'backofficer_actions'
      elsif analyst_signed_in?
        'analyst_actions'
      end
  end

  def current_action_name
    action_name == 'my_incidents' || 'search' ? 'index' : action_name
  end

  def disable_solve_button?(incident)
    return 'disabled' if
      (incident.status == Status::CLOSED || incident.status == Status::SOLVED) ||
      (incident.status == Status::ANALYSING && incident.analyst_id == current_analyst.id) ||
      ((incident.status == Status::ANALYSING || incident.status == Status::PENDING) && incident.analyst_id != current_analyst.id)
  end

  def solve_incident?(incident)
    return true if
      incident.status == Status::OPEN ||
      (incident.status == Status::CLOSED || incident.status == Status::SOLVED) ||
      (incident.status == Status::ANALYSING && incident.analyst_id == current_analyst.id)
  end

  def link_to_solve_incident(incident)
    link = []

    if incident.status == Status::OPEN
      link << link_to('Resolver Requisição', solve_incident_path(incident), class: 'btn btn-success disabled')
    elsif incident.status == Status::ANALYSING && incident.analyst_id == current_analyst.id
      link <<  link_to('Resolver Requisição', solve_incident_path(incident), method: :get, class: 'btn btn-success')
    elsif incident.status == Status::CLOSED || incident.status == Status::SOLVED
      link << link_to('Resolver Requisição', edit_incident_path(incident), class: 'btn btn-success disabled')
    end

    safe_join(link)
  end
end
