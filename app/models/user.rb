class User < ApplicationRecord
  before_validation :generate_device_token, on: :create
  validates :device_token, presence: true, uniqueness: true

  private

  def generate_device_token
    self.device_token ||= SecureRandom.urlsafe_base64(32)
  end

end
