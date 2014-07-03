class Project < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :date_started
  validates_numericality_of :no_of_sprints, greater_than: 0
  validates_numericality_of :price_per_sprint, greater_than: 0
  validates_presence_of :quotation_no

  self.per_page = 5

end
