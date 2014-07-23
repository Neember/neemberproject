class Absence < ActiveRecord::Base
  default_scope -> { order(date: :desc, id: :desc) }

  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :first_name, to: :coder, prefix: true, allow_nil: true

  belongs_to :project
  belongs_to :coder

  validates :date, presence: true
  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 8 }
  validates :reason, presence: true
  validates :project_id, presence: true
  validates :coder, presence: true

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
