class ProjectPresenter < Presenter
  alias_method :project, :model

  def estimated_completion
    project.estimated_completion unless project.completed?
  end

  def progress
    overrun? ?
      I18n.t('helpers.label.project.overruns', count: project.overruns) :
      I18n.t('helpers.label.project.left_over_days', count: project.left_over_days)
  end

  def client_link
    link_to project.client_company_name, edit_client_path(project.client_id) if project.client.present?
  end

  def css_classes
    overrun? ? 'danger' : (completed? ? 'success' : 'info')
  end

  def completed_percentage
    "#{project.completed_percentage}%"
  end

  def milestone_project
    milestone_project_array = []
    milestone_project_array.push({name: 'date_started', date: project.date_started})
    project.work_logs.unworking.after_date(project.date_started).each do |unworking|
      milestone_project_array.push({name: 'absence', date: unworking.date})
    end
    milestone_project_array.push({name: 'tcd', date: project.target_completion}) if project.target_completion
    milestone_project_array.push({name: 'ecd', date: project.estimated_completion}) if project.estimated_completion
    milestone_project_array.push({name: 'date_completed', date: project.date_completed}) if project.date_completed
    milestone_project_array.sort_by { |obj| obj[:date] }
  end
end
