class PivotalVelocityGetter
  def update_velocity
    PivotalTracker::Client.token= ENV['PIVOTAL_ACCESS_TOKEN']
    pivotal_projects = PivotalTracker::Project.all
    pivotal_projects.each do |pivotal_project|
      project = Project.find_by_pivotal_project_id(pivotal_project.id)
      project.update(velocity: pivotal_project.current_velocity) if project.present?
    end
  end
end
