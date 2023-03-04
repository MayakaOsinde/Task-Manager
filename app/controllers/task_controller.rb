require 'sinatra/session'

class TaskController < Sinatra::Base

    enable :sessions


    set :default_content_type, 'application/json'


    # A get request method
    # get '/tasks' do
    #     task = Task.all
    #     task.to_json
    # end


    # Create a new task
    post '/tasks/create' do
      

      if session[:user_id]

        request.body.rewind
        data = JSON.parse(request.body.read)
      
        task = Task.new(
          title: data['title'],
          description: data['description'],
          collaborators: data['emails'],
          due_date: data['due_date'],
          user_id: session["user_id"]
        )
      
        if task.save
          status 201
          task.to_json
        else
          status 422
          { errors: task.errors }.to_json
        end
      else 
        status 403
        { error: "Please log in" }.to_json
      end
        
    end


    # get "/tasks/usertasks" do
    #   # Check if the user is logged in
    #   # redirect "/login" unless session[:user_id]
    
    #   # Retrieve all tasks for the logged in user
    #   tasks = db.execute("SELECT * FROM tasks WHERE user_id = ?", session[:user_id])
    

    # end
    # A post request method
    # post '/tasks' do
    #     task_params = JSON.parse(request.body.read)
    #     task = Task.new(task_params)
        
    #     if task.save
    #       status 201
    #       task.to_json
    #     else
    #       status 422
    #       { errors: task.errors.full_messages }.to_json
    #     end
    # end

    
    
    # Get more information on a task by id
      get '/tasks/mytasks' do
        if session[:user_id]
          task = Task.where(user_id: session[:user_id])

          if task
            task.to_json
          else
            status 404
          end
        else
          status 403
          {error: "Log in"}.to_json
        end
      end

      # private
      
      # def current_user
      #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
      # end


    # A remove/ delete method
      delete '/tasks/delete/:id' do
          task = Task.find_by(id: params[:id])
          
          if task
            task.destroy
            status 204
          else
            status 404
            { error: "Task not found" }.to_json
          end
      end

    # Filter through tasks using the date the task was created
    get '/tasks/filter' do
        if params[:created_at].present?
          tasks = Task.where(created_at: params[:created_at])
          tasks.to_json
        else
          tasks = Task.all
          tasks.to_json
        end
    end
  end

