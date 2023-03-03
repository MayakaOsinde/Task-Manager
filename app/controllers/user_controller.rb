require 'bcrypt'
require 'sinatra'
require 'bcrypt'
require 'json'
require_relative '../models/user'


class UserController < Sinatra::Base

    # Lists all users
    # get '/users' do
    #     users = User.all
    #     users.to_json
    # end

    post '/users/register' do
      # Get user information from request body
      data = JSON.parse(request.body.read)
    
      # Create a new user object
      user = User.new(
        first_name: data['first_name'],
        middle_name: data['middle_name'],
        last_name: data['last_name'],
        email: data['email'],
        age: data['age'],
        password: data['password']
      )
    
      # Save the user to the database
      if user.save
        # Return success message
        { message: 'User created successfully' }.to_json
      else
        # Return error message
        halt 400, { error: user.errors.full_messages.join(', ') }.to_json
      end
    end
    
      
      # Route for authenticating a user's credentials
      require 'sqlite3'

      # Open the database
      db = SQLite3::Database.open('your_database_name.db')
      
      post '/users/login' do
        # Get user information from request body
        data = JSON.parse(request.body.read)
    
        # Find user by email
        user = User.find_by(email: data['email'])
    
        # Check if user exists and password matches
        if user && user.authenticate(data['password'])
          # Return success message with user details
          { message: 'User authenticated successfully', user: user }.to_json
        else
          # Return error message
          halt 401, { error: 'Invalid email or password' }.to_json
        end
      end
        
      # Close the database
      # db.close
      
end