class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # api
  before_save :ensure_authentication_token!

  has_many :lists
  has_many :tasks

  def role?(base_role)
    role == base_role.to_s
  end

  # api
  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  # Sarbanes-Oxley compliance: ensure strong password (not stricly necessary for api)
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  # api
  def password_presence
    password.present? && password_confirmation.present?
  end

  # api
  def password_match
    password == password_confirmation
  end

  # api
  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  # api
  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(authentication_token: token).first
    end
  end

  # api
  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end
end
