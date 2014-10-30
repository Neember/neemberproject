class PivotalProjectTracker
  def initialize
    assign_pivotal_access_token
  end

  def sync_projects
    pivotal_projects.each do |pivotal_project|
      project = Project.find_by_pivotal_project_id(pivotal_project.id)
      project.update(
        points_left: points_left_of(pivotal_project),
        velocity: pivotal_project.current_velocity
      ) if project.present?
    end
  end

  private
  def assign_pivotal_access_token
    PivotalTracker::Client.token = ENV['PIVOTAL_ACCESS_TOKEN']
  end

  def pivotal_projects
    PivotalTracker::Project.all
  end

  def points_left_of(pivotal_project)
    uncompleted_stories_of(pivotal_project).sum { |story| points_of(story) }
  end

  def uncompleted_stories_of(pivotal_project)
    pivotal_project.stories.all(uncompleted_scopes)
  end

  def uncompleted_scopes
    { story_type: :feature, current_state: [:started, :unscheduled] }
  end

  def points_of(story)
    (story.estimate > 0) ? story.estimate : 0
  end
end
