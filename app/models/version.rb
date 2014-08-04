class Version < PaperTrail::Version
  belongs_to :user, foreign_key: 'whodunnit'

  delegate :first_name, to: :user, prefix: true, allow_nil: true

  def creator_name
    user_first_name || 'System'
  end
end
