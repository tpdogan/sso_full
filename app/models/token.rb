class Token < ApplicationRecord
  belongs_to :userApp, optional: true
  
  before_create do
    self.access_token = SecureRandom.alphanumeric(40)
  end
end
