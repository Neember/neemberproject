class Project < ActiveRecord::Base
  after_initialize :assigns_default_values

  validates_presence_of :name
  validates_presence_of :date_started
  validates_numericality_of :no_of_sprints, greater_than: 0
  validates_numericality_of :price_per_sprint, greater_than: 0
  validates_presence_of :quotation_no
  validates_presence_of :client_id
  validates_numericality_of :pivotal_project_id

  DOMAIN_REGEX =   /(^(http|https):\/\/-)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :domain, multiline: true, :with => DOMAIN_REGEX

  belongs_to :client
  has_and_belongs_to_many :coders, join_table: 'coders_projects'
  has_many :absences

  default_scope -> { order(name: :asc, id: :desc) }

  def assigns_default_values
    self.date_started ||= Date.today
  end

  def calculator_target_completion
    self.date_started + self.no_of_sprints * 14
  end

  def estimated_completion
    return nil if velocity.zero?
    week = self.points_left / self.velocity.to_f
    Date.today + week.ceil * 7
  end
end
