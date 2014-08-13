class Project < ActiveRecord::Base

  default_scope -> { order(name: :asc, id: :desc) }

  WEEK_DAYS = 7
  WORKING_DAYS = 5
  WORKING_HOURS = 8.0
  DAYS_PER_SPRINTS = WEEK_DAYS * 2
  DOMAIN_REGEX =   /(^(http|https):\/\/-)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  delegate :company_name, :name, :email, :designation, :phone, :address, to: :client, prefix: true, allow_nil: true

  has_and_belongs_to_many :coders, join_table: 'coders_projects'
  has_many :absences
  has_many :work_logs

  validates :name, :date_started, :quotation_no, :client_id, presence: true
  validates :no_of_sprints, :price_per_sprint, numericality: { greater_than: 0 }
  validates :pivotal_project_id, numericality: { only_integer: true }
  validates :velocity, numericality: { only_integer: true, greater_than: 0 }
  validates :domain, format: { multiline: true, :with => DOMAIN_REGEX }

  after_initialize :assigns_default_values

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  def client
    Client.find(self.client_id)
  end

  def client=(client)
    self.client_id = client.id
  end

  def assigns_default_values
    self.date_started ||= Date.today
  end

  def target_completion
    date_started + no_of_sprints * DAYS_PER_SPRINTS + unworked_days
  end

  def unworked_days
    unworked_hours / WORKING_HOURS
  end

  def estimated_completion
    date_completed || Date.today + week_left.ceil * WEEK_DAYS
  end

  def overruns
    if overrun?
      if completed? then
        (left_over_days < 0) ? left_over_days.abs : completed_overruns
      else
        estimated_overruns
      end
    else
      0
    end
  end

  def left_over_days
    if completed?
      exceeding_days - working_days_after_completed.size
    else
      0
    end
  end

  def completed?
    date_completed?
  end

  def overrun?
    overrun_estimated? || really_overrun? || left_over_days < 0
  end

  def really_overrun?
    completed? && self.work_logs.working.size > ( self.no_of_sprints * WORKING_DAYS )
  end

  def overrun_estimated?
    !completed? && estimated_completion > target_completion
  end

  def commits
    return [] if repository.blank?
    github = Github.new oauth_token: ENV['GITHUB_ACCESS_TOKEN']
    github.repos.commits.all ENV['GITHUB_USERNAME'], self.repository, per_page: 20
  end

  def project_commits
    return [] if repository.blank?
    github = Github.new oauth_token: ENV['GITHUB_ACCESS_TOKEN']
    github.repos.commits.all ENV['GITHUB_USERNAME'], self.repository, per_page: 100
  end

  private
  def week_left
    points_left / velocity.to_f
  end

  def unworked_hours
    work_logs.unworking.inject(0) { |total, work_log| total + work_log.hours }
  end

  def exceeding_days
      date_completed.business_days_until(target_completion)
  end

  def working_days_after_completed
    self.work_logs.after_date(date_completed).working
  end

  def completed_overruns
    target_completion.business_days_until(date_completed)
  end

  def estimated_overruns
    target_completion.business_days_until(estimated_completion)
  end
end
