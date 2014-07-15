class PivotalProjectTracker
  def update_velocity
    pivotal_access_token

    pivotal_projects = PivotalTracker::Project.all
    pivotal_projects.each do |pivotal_project|
      project = Project.find_by_pivotal_project_id(pivotal_project.id)
      project.update(velocity: pivotal_project.current_velocity) if project.present?
    end
  end

  def update_points_left
    pivotal_access_token

    pivotal_projects = PivotalTracker::Project.all
    pivotal_projects.each do |pivotal_project|
      project = Project.find_by_pivotal_project_id(pivotal_project.id)
      stories = pivotal_project.stories.all(story_type: :feature, current_state: [:started, :unscheduled])
      points_left = stories.sum { |story| (story.estimate > 0) ? story.estimate : 0  }
      project.update(points_left: points_left) if project.present?
    end
  end

  private
  def pivotal_access_token
    PivotalTracker::Client.token = ENV['PIVOTAL_ACCESS_TOKEN']
  end
end
