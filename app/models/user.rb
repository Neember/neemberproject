class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name

  has_and_belongs_to_many :projects, join_table: 'coders_projects', foreign_key: 'coder_id'
  has_many :schedules, class_name: 'Schedule', foreign_key: 'coder_id'

  default_scope -> {order(first_name: :asc, last_name: :asc, id: :desc)}

  def name
    "#{first_name} #{last_name}"
  end

  def self.options
    User.all.collect{|user| [ user.name, user.id ] }
  end

  def get_schedules_by_user
    Schedule.where(coder: self)
  end

  private
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
