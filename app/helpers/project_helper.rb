module ProjectHelper
  def coders_link_list(coders)
    coders.map { |coder| coder_link(coder) }.join(', ').html_safe
  end

  def coder_link(coder)
    link_to coder.first_name, edit_user_path(coder.id)
  end

  def project_options(projects)
    projects.collect { |project| [ project.name, project.id ] }
  end

  def project_css(project)
    'alert-danger' if project.overrun?
  end

  def version_diff(version)
    version.changeset.collect { |field, value|
      field_diff(field: field, old_value: value[0], new_value: value[1], event: version.event)
    }.join('<br>').html_safe
  end

  def field_diff(field: , new_value: , old_value: '', event:)
    translate_key = "project.events.#{event}"
    field_name = label_name("project.#{field}")

    t(translate_key,
      field: field_name,
      old_value: old_value,
      new_value: new_value
    )
  end
end
