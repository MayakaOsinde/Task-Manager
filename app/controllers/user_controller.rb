class UserController < Sinatra::Base

    set :default_content_type, 'application/json'

    # Lists all users
    # get '/users' do
    #     users = User.all
    #     users.to_json
    # end

    post '/auth/register' do
        # Get user information from request body
        data = JSON.parse(request.body.read)
      
        # Validate required fields
        unless data['first_name'] && data['last_name'] && data['email'] && data['age'] && data['password']
          halt 400, { error: 'Missing required fields' }.to_json
        end
      
        # Validate email format
        unless data['email'] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
          halt 400, { error: 'Invalid email format' }.to_json
        end
      
        # Validate age
        unless data['age'].to_i > 0 && data['age'].to_i < 150
          halt 400, { error: 'Invalid age' }.to_json
        end
      
        # Hash the password using Bcrypt
        password_hash = BCrypt::Password.create(data['password'])
      
        # Create a new user object with hashed password
        user = {
          first_name: data['first_name'],
          middle_name: data['middle_name'],
          last_name: data['last_name'],
          email: data['email'],
          age: data['age'],
          password_hash: password_hash
        }
      
        # Add user to the database
        users[data['email']] = user
      
        # Return success message
        { message: 'User created successfully' }.to_json
    end
      
      # Route for authenticating a user's credentials
    post '/auth/login' do
        # Get user information from request body
        data = JSON.parse(request.body.read)
      
        # Validate required fields
        unless data['email'] && data['password']
          halt 400, { error: 'Missing required fields' }.to_json
        end
      
        # Find user by email
        user = users[data['email']]
      
        # Check if user exists and password is correct
        if user && BCrypt::Password.new(user[:password_hash]) == data['password']
          # Return success message
          { message: 'User authenticated successfully' }.to_json
        else
          # Return error message
          { error: 'Invalid email or password' }.to_json
        end
    end
end