class ProjectPresenter < Presenter
  alias_method :project, :model

  def estimated_completion
    project.estimated_completion unless project.completed?
  end

  def overruns
    I18n.t('helpers.label.project.overruns', count: project.overruns) if overrun?
  end

  def client_link
    link_to project.client_company_name, edit_client_path(project.client_id) if project.client.present?
  end

  def css_classes
    'alert-danger' if overrun?
  end
end
