task sync_projects: :environment do
  PivotalProjectTracker.new.sync_projects
end
