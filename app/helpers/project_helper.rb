module ProjectHelper
  def coders_link_list(coders)
    coders.map { |coder| coder_link(coder) }.join(' ').html_safe
  end

  def coder_link(coder)
    link_to coder.name, user_path(coder.id), class: 'btn btn-link'
  end
end
