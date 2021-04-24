class UserApp < ApplicationRecord
  validates_presence_of :user_id, :client_id
  validate :code_xor_token
  
  private
  def code_xor_token
    unless self.auth_id.present? ^ self.token_id.present?
      errors.add(:base, 'Either auth_code or access_token must be present!')
    end
  end
end
