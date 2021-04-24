class Client < ApplicationRecord
  validates_presence_of :client_name

  before_create do
    self.client_id = SecureRandom.uuid
    self.client_secret = SecureRandom.alphanumeric(40)
  end
end
