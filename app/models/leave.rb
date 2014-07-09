class Leave < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :hours
  validates_presence_of :reason

  belongs_to :coder, class_name: 'User'

  default_scope -> { order(id: :desc) }
end
