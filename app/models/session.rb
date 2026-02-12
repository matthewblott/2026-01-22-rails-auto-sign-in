class Session < ApplicationRecord
  # belongs_to :user
  # before_validation :generate_token, on: :create
  #
  # private
  #
  # def generate_token
  #   # self.token ||= SecureRandom.hex(32)
  #   self.token ||= SecureRandom.urlsafe_base64(32)
  # end

end
