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
    post '/users/login' do
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