class Schedule < ActiveRecord::Base
  after_initialize :assigns_default_values

  validates_presence_of :date
  validates_presence_of :hours
  validates_presence_of :reason
  validates_presence_of :coder_id
  validates_presence_of :project_id

  belongs_to :coder, class_name: 'User'
  belongs_to :project

  default_scope -> { order(id: :desc) }

  def assigns_default_values
    self.date ||= Date.today
  end
end
