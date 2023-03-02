class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'


    # A get request method
    get '/tasks' do
        task = Task.all
        task.to_json
    end

    # Create a new task
    post '/tasks' do
        request.body.rewind
        data = JSON.parse(request.body.read)
      
        task = Task.new(
          title: data['title'],
          description: data['description'],
          emails: data['emails'],
          due_date: data['due_date']
        )
      
        if task.save
          status 201
          task.to_json
        else
          status 422
          { errors: task.errors }.to_json
        end
    end

    # A post request method
    post '/tasks' do
        task_params = JSON.parse(request.body.read)
        task = Task.new(task_params)
        
        if task.save
          status 201
          task.to_json
        else
          status 422
          { errors: task.errors.full_messages }.to_json
        end
    end

    # A remove/ delete method
    delete '/tasks/:id' do
        task = Task.find_by(id: params[:id])
        
        if task
          task.destroy
          status 204
        else
          status 404
          { error: "Task not found" }.to_json
        end
    end

    # Check if a user is authenticated
    post '/login' do
        request.body.rewind
        data = JSON.parse(request.body.read)
      
        user = User.find_by(email: data['email'])
        if user && BCrypt::Password.new(user.password_digest) == data['password']
          session[:user_id] = user.id
          status 200
          { message: 'Logged in successfully' }.to_json
        else
          status 401
          { error: 'Invalid email or password' }.to_json
        end
    end

    # 
end

