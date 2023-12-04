require 'jwt'

class JwtService
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.generate_token(payload, expiry = 24.hours.from_now)
    payload[:exp] = expiry.to_i
    JWT.encode(payload,SECRET_KEY)
  end

  # @param [Object] token
  def self. decode(token)
    decode_data = JWT.decode(token,SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decode_data)
  rescue JWT::ExpiredSignature
    {message:"Token Expired"}
  end
end
