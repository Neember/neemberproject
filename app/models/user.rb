class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_format_of :email, :with => /\A([^@\s]+)@(futureworkz.com)\Z/i

  default_scope -> { order(first_name: :asc, last_name: :asc, id: :desc) }

  def name
    "#{first_name} #{last_name}"
  end

  def self.options
    User.all.collect { |user| [user.name, user.id] }
  end

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
        is_admin: false,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
