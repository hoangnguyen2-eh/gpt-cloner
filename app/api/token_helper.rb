require 'jwt'

class TokenHelper
    def self.decode_token(token)
        secret_key = 'my-secret-key' # TODO: add into environment variable
        decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
        decoded_token.first
    end
    
    def self.create_token(username)
        payload = { username: username }
        secret_key = 'my-secret-key' # TODO: add into environment variable

        JWT.encode(payload, secret_key, 'HS256')
    end
end