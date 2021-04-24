class Token < ApplicationRecord
  before_create do
    self.access_token = SecureRandom.alphanumeric(40)
  end
end
