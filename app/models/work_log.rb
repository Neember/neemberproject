class WorkLog < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(date: :asc, id: :asc) }
  scope :working, -> { where(status: :worked) }
  scope :unworking, -> { where(status: :unworked) }
  scope :after_date_completed, -> (date) { where("date > ?", date) }


  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :first_name, to: :coder, prefix: true, allow_nil: true

  belongs_to :project
  belongs_to :coder

  validates :date, :status, :project_id, :coder, presence: true
  validates :hours, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 8 }
  validates :reason, presence: {if: -> {status.present? && status.unworked?}}
  validate :eight_hours_per_day

  enumerize :status, in: [:worked, :unworked], default: :worked

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end

  def eight_hours_per_day
    if WorkLog.where(coder: self.coder, date: self.date).sum(:hours) > 8
      errors.add(:date, t('work_log.message.validate_date'))
    end
  end
end
