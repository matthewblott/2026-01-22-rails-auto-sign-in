class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end
