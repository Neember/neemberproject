class Admin < User

  validates :is_admin, :acceptance => {:accept => true}

  default_scope -> { where(is_admin: true) }
end
