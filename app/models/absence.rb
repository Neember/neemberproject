class Absence < ActiveRecord::Base
  default_scope -> { order(date: :desc, id: :desc) }

  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :first_name, to: :coder, prefix: true, allow_nil: true

  belongs_to :project
  belongs_to :coder

  validates_presence_of :date
  validates_presence_of :hours
  validates_presence_of :reason
  validates_presence_of :project_id
  validates_presence_of :coder
  validates_numericality_of :hours, greater_than: 0
  validates_numericality_of :hours, less_than_or_equal_to: 8

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
