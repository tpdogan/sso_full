class User < ApplicationRecord
  validates_presence_of :username, :password
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 6

  before_create do
    require "openssl"
    key = "8a6f4407980a072017cef7204d70604051caff05c4f94f5778d09a0cda844494b775160dd9d1e8cc432df23090abaf1f8df9af93b6ed8105fb05ea990d596a95"
    self.password = OpenSSL::HMAC.hexdigest("sha256", key, self.password)
  end
end
