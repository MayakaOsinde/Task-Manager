require 'bcrypt'
require 'sinatra'
require 'bcrypt'
require 'json'
require_relative '../models/user'
require 'sinatra/session'



class UserController < Sinatra::Base

    # Lists all users
    # get '/users' do
    #     users = User.all
    #     users.to_json
    # end

    enable :sessions

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
    
      
      
    post '/users/login' do

      # Get user information from request body
      data = JSON.parse(request.body.read)
  
      # Find user by email
      user = User.find_by(email: data['email'])
  
      # Check if user exists and password matches
      if user && user.authenticate(data['password'])
        # Return success message with user details
        session[:user_id] = user.id
        halt 200, { message: 'User authenticated successfully' }.to_json

      else
        # Return error message
        halt 401, { error: 'Invalid email or password' }.to_json
      end
    end
        
    get '/users/logout' do
      
      if session[:user_id]
        # Remove user id from session
      session.clear
      halt 200, { message: 'User logged out successfully' }.to_json
      else 
        {error: 'Please log in'}
        halt 403
      end      
    end
      
end