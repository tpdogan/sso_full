class UserApp < ApplicationRecord
  validates_presence_of :user_id, :client_id

  belongs_to :user
  belongs_to :client

  has_one :auth, dependent: :destroy
  has_one :token, dependent: :destroy
end
