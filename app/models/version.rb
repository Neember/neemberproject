class Version < PaperTrail::Version
  belongs_to :user, foreign_key: 'whodunnit'

  delegate :first_name, to: :user, prefix: true
end
