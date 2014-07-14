class Coder < User

  has_and_belongs_to_many :projects, join_table: 'coders_projects'
  has_many :absences, through: :projects

  default_scope -> { where(is_admin: false) }
end
