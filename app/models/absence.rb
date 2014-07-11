class Absence < ActiveRecord::Base
  after_initialize :assigns_default_values

  validates_presence_of :date
  validates_presence_of :hours
  validates_presence_of :reason
  validates_presence_of :project_id
  validates_numericality_of :hours, greater_than: 0
  validates_numericality_of :hours, less_than_or_equal_to: 8

  belongs_to :project

  default_scope -> { order(date: :desc, id: :desc) }

  def assigns_default_values
    self.date ||= Date.today
  end
end
