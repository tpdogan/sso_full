class Auth < ApplicationRecord
  belongs_to :userApp, optional: true
  
  before_create do
    self.auth_code = SecureRandom.alphanumeric(40)
  end
end
