class User < ApplicationRecord
  validates_uniqueness_of :email, :api_key
  validates_presence_of :email, :password, :api_key
  has_secure_password

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'mod3isalmostover')
  end
end
