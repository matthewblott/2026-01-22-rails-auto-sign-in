class User < ApplicationRecord
  # has_secure_password
  # has_many :sessions, dependent: :destroy

  # after_update if: :password_digest_previously_changed? do
  #   sessions.where.not(id: Current.session).delete_all
  before_validation :generate_device_token, on: :create

  validates :device_token, presence: true, uniqueness: true

  private

  def generate_device_token
    self.device_token ||= SecureRandom.urlsafe_base64(32)
  end

end
