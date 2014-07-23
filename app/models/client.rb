class Client < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(first_name: :asc, last_name: :asc, id: :desc) }

  scope :options, -> { pluck(:company_name, :id) }

  has_many :projects

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :company_name, presence: true
  validates :designation, presence: true
  validates :email, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  enumerize :title, in: [:mr, :mrs, :ms, :dr, :mdm], default: :mr

  def name
    "#{first_name} #{last_name}"
  end
end
