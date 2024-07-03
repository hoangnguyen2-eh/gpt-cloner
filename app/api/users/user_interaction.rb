class Users::UserInteraction < Grape::API
  version 'v1', using: :path
  format :json

  resource :user do
    desc 'Register a new user'
    params do
      requires :name, type: String, desc: 'User name'
      requires :password, type: String, desc: 'User password'
    end
    post '/register' do
      # Your registration logic here
      # Example: create a new user record
      hashedPassword = PasswordHelper.encrypt(params[:password])
      User.create(username: params[:name], password: hashedPassword)
    end

    desc 'Login a user'
    params do
      requires :name, type: String, desc: 'User name'
      requires :password, type: String, desc: 'User password'
    end
    post '/login' do
      Rails.logger.info "Login attempt for user #{params[:name]}"
      user = User.find_by(username: params[:name])

      if user && PasswordHelper.isValidPassword?(params[:password], user.password)
        Rails.logger.info "Generate token for user #{params[:name]}"
        token = TokenHelper.create_token(params[:name])

        # assign to cookies
        cookies[:token] = { value: token, httponly: true, expires: 1.hour.from_now }
        { message: 'Login successful' }
      else
        error!({ message: 'Invalid credentials' }, 401)
      end
    end

    desc 'Get user profile'
    get do
      Rails.logger.info "Get user profile"
      userValidator = UserValidator.new(cookies[:token])
      if userValidator.valid?
        return User.find_by(username: userValidator.getUserName).to_json
      else
        error!({ message: 'Unauthorized' }, 401)
      end
    end

    desc 'Return a sample user'
    get :example do
      { message: 'OK' }.to_json
    end
  end
end