class Client < ActiveRecord::Base
  extend Enumerize

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :address
  validates_presence_of :company_name
  validates_presence_of :designation
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  enumerize :title, in: [:mr, :mrs, :ms], default: :mr
end
