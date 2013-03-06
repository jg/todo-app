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


        builder.set_template do |template|
          Task.accepted_params.each {|k,v| template.add_data(k, prompt: v) }
        end
      end

      # builder.add_query(Routes['tasks#completed'], "completed", prompt: "completed tasks") do |query|
      # end
    end.to_json


    respond_to do |format|
      format.json { render :json => json }
    end
  end

  def create
    task = Task.new.tap do |t|
      # assign accepted keys to Task instance
      task_params = params['task']
      (task_params.keys & Task.accepted_params.keys).each do |key|
        t.send("#{key}=".to_sym, task_params[key])
      end
      # assign user
      t.user = current_user
    end

    respond_to do |format|
      if task.save
        format.json { render :status => 201, :text => "OK"}
      else
        format.json {render :status => 400, :text => "OK"}
      end
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end
end
