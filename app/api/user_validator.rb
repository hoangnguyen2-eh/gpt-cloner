require_relative 'token_helper'

class UserValidator
    def initialize(token)
        @token = token
    end

    def valid?
        begin
            decoded_token = TokenHelper.decode_token(@token)
            decoded_token['username'].present? && User.find_by(username: decoded_token['username']).present? 
        rescue JWT::DecodeError
            false
        end
    end

    def getUserName
        decoded_token = TokenHelper.decode_token(@token)
        decoded_token['username']
    end
end