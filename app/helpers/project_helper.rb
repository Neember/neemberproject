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
    if project.compare_ecd_tcd
      'alert-danger'
    end
  end
end
