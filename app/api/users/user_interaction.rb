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

    desc 'Return a sample user'
    get :example do
      { message: 'OK' }.to_json
    end
  end
end