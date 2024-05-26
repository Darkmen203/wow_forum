class User < ApplicationRecord
  validates :provider, :login, :token, presence: true
  has_many :questions
  has_many :answers


  def send_password_reset
    generate_reset_password_token
    self.reset_password_sent_at = Time.zone.now
    save!
    puts 'save time when greated token'
    UserMailer.password_reset(self).deliver_now
  end

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    puts 'generated password token '
  end

  def password_reset_expired?
    reset_password_sent_at < 10.minutes.ago
  end


end
