class TasksController < ApplicationController

  def index
    tasks = current_user.tasks

    json = CollectionJSON.generate_for(Routes['tasks#index']) do |builder|
      tasks.each do |task|
        builder.add_item(Routes['tasks#show'].(task.id)) do |item|
          item.add_data("id", value: task.id)
          item.add_data("title", value: task.title)
          item.add_data("created_at", value: task.created_at)
          item.add_data("updated_at", value: task.updated_at)
          item.add_data("completed_at", value: task.completed_at)
          item.add_data("priority", value: task.priority)
          item.add_data("due_date", value: task.due_date)
          item.add_data("due_time", value: task.due_time)
          item.add_data("repeat", value: task.repeat)
          item.add_data("task_list", value: task.task_list)

          item.add_link(Routes['tasks#destroy'].(task.id), 'destroy')
          item.add_link(Routes['tasks#create'].(task.id), 'add')
          item.add_link(Routes['tasks#edit'].(task.id), 'edit')
        end


      end

      builder.set_template do |template|
        Task.accepted_params.each {|k,v| template.add_data(k, prompt: v) }
      end
      # builder.add_query(Routes['tasks#completed'], "completed", prompt: "completed tasks") do |query|
      # end
    end.to_json


    respond_to do |format|
      format.json { render :json => json }
    end
  end

  def create
    task = Task.from_params(params)
    task.user = current_user

    respond_to do |format|
      # found 'same' task in db
      if server_task = current_user.tasks.where("created_at = ?", task.created_at).first
        # POSTed task has been updated more recently
        if task.updated_at > server_task.updated_at
          # update attributes on server
          task.attributes.each do |k,v|
            server_task.update_attribute(k, v) if k != "id"
          end
          if server_task.save
            format.json { render :status => 201, :text => "created"}
          else
            format.json {render :status => 400, :text => "error"}
          end
        else
          # no change
          format.json {render :status => 200, :text => "unchanged"}
        end
      else
        # client POSTed a new task, save it
        if task.save
          format.json { render :status => 201, :text => "created"}
        else
          format.json {render :status => 400, :text => "error"}
        end
      end
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end
end
