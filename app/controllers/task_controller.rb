class TaskController < Sinatra::Base


    set :default_content_type, 'application/json'


    # A get request method
    get '/tasks' do
        task = Task.all
        task.to_json
    end

    # Create a new task
    post '/tasks/create' do
        request.body.rewind
        data = JSON.parse(request.body.read)
      
        task = Task.new(
          title: data['title'],
          description: data['description'],
          collaborators: data['emails'],
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
    get '/tasks/:id' do
        task = Task.find_by(id: params[:id])
      
        if task
          task.to_json
        else
          status 404
          { error: 'Task not found' }.to_json
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