
class PasswordHelper
    def self.encrypt(password)
        BCrypt::Password.create(password)
    end

    def self.isValidPassword?(password, encrypted_password)
        BCrypt::Password.new(encrypted_password) == password
    end
end
