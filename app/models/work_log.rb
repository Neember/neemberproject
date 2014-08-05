class WorkLog < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(date: :asc, id: :asc) }

  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :first_name, to: :coder, prefix: true, allow_nil: true

  belongs_to :project
  belongs_to :coder

  validates :date, :status, :project_id, :coder, presence: true
  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 8 }
  validates :reason, presence: {if: -> {status.present? && status.unworked?}}

  enumerize :status, in: [:worked, :unworked], default: :worked

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
