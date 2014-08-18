class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  default_scope -> { order(first_name: :asc, last_name: :asc, id: :desc) }

  validates :first_name, :last_name, presence: true
  validates :email, format: { :with => /\A([^@\s]+)@(futureworkz.com)\Z/i }

  def name
    "#{first_name} #{last_name}"
  end

  def self.options
    User.all.collect { |user| [user.name, user.id] }
  end

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    User.where(email: (data['email']).downcase).first
  end

  private
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
