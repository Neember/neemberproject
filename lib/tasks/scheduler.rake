task get_velocity: :environment do
  PivotalVelocityGetter.new.update_velocity
end
