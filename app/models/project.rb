class Project < ActiveRecord::Base
  after_initialize :assigns_default_values

  validates_presence_of :name
  validates_presence_of :date_started
  validates_numericality_of :no_of_sprints, greater_than: 0
  validates_numericality_of :price_per_sprint, greater_than: 0
  validates_presence_of :quotation_no
  validates_presence_of :client_id
  validates_presence_of :user_id

  DOMAIN_REGEX =   /(^(http|https):\/\/-)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :domain, multiline: true, :with => DOMAIN_REGEX

  belongs_to :client
  belongs_to :user

  default_scope -> { order(id: :desc) }

  self.per_page = 5

  def assigns_default_values
    self.date_started ||= Date.today
  end

end
