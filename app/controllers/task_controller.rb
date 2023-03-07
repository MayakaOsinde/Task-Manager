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
    post '/tasks/create/:user_id' do
      

      # if session[:user_id]

        request.body.rewind
        data = JSON.parse(request.body.read)
      
        task = Task.new(
          title: data['title'],
          description: data['description'],
          due_date: data['due_date'],
          user_id: data['user_id']
        )
      
        if task.save
          status 201
          task.to_json
        else
          status 422
          { errors: task.errors }.to_json
        end
      # else 
      #   status 403
      #   { error: "Please log in" }.to_json
      # end
        
    end

    
    
    # Get more information on a task by id
      get '/tasks/:user_id' do
          task = Task.where(user_id: params[:user_id])

          if task
            task.to_json
          else
            status 403
          end
      end



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
    

      put '/tasks/update/:id' do
        task = Task.where(params[:id])
        if task.update(completed: params[:completed])
          json task
        else
          status 400
          json task.errors
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

