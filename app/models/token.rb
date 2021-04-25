class Token < ApplicationRecord
  belongs_to :userApp, optional: true
  
  before_create do
    self.access_token = SecureRandom.alphanumeric(40)
  end

  after_create do
    userApp = UserApp.find(self.user_app_id)
    userApp.auth&.destroy
  end
end
