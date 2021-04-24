class Auth < ApplicationRecord
  before_create do
    self.auth_code = SecureRandom.alphanumeric(40)
  end
end
