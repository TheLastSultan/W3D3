class User < ApplicationRecord
  validates :user_name, :session_token, uniqueness: true
  validates :password_digest, presence: true

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = Bcrypt::Password.create(pw)
  end


  def is_password?(pw)
    Bcrypt::Password.new(self.password_digest).is_password?(pw)
  end
end
