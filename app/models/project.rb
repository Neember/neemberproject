class Project < ActiveRecord::Base
  after_initialize :assigns_default_values

  validates_presence_of :name
  validates_presence_of :date_started
  validates_numericality_of :no_of_sprints, greater_than: 0
  validates_numericality_of :price_per_sprint, greater_than: 0
  validates_presence_of :quotation_no
  validates_presence_of :client_id
  validates_numericality_of :pivotal_project_id
  validates_numericality_of :velocity, greater_than: 0

  WEEK_DAYS = 7
  WORKING_DAYS = 5
  WORKING_HOURS = 8.0
  DAYS_PER_SPRINTS = WEEK_DAYS * 2
  DOMAIN_REGEX =   /(^(http|https):\/\/-)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :domain, multiline: true, :with => DOMAIN_REGEX

  belongs_to :client
  has_and_belongs_to_many :coders, join_table: 'coders_projects'
  has_many :absences

  delegate :company_name, to: :client, prefix: true, allow_nil: true

  default_scope -> { order(name: :asc, id: :desc) }

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
      completed? ? completed_overruns : estimated_overruns
    else
      0
    end
  end

  def completed?
    date_completed?
  end

  def overrun?
    overrun_estimated? || really_overrun?
  end

  def really_overrun?
    completed? && date_completed > target_completion
  end

  def overrun_estimated?
    !completed? && estimated_completion > target_completion
  end

  private
  def week_left
    points_left / velocity.to_f
  end

  def unworked_hours
    absences.inject(0) { |total, absences| total + absences.hours  }
  end

  def completed_overruns
    working_days_between(date_completed, target_completion)
  end

  def estimated_overruns
    working_days_between(estimated_completion, target_completion)
  end

  def working_days_between(date_1, date_2)
    (((date_1 - date_2) / WEEK_DAYS) * WORKING_DAYS).ceil
  end
end
