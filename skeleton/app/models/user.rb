# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true

  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat
  

  after_initialize do |user|
   user.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    debugger
    self.session_token = SecureRandom::urlsafe_base64
   # user.save!
    self.session_token
  end

  def password=(password)
    debugger
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    debugger
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    debugger
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end
end
