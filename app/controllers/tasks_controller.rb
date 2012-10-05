class TasksController < ApplicationController
  def index
    tasks = current_user.tasks

    json = CollectionJSON.generate_for(Routes['tasks#index']) do |builder|
      tasks.each do |task|
        builder.add_item(Routes['tasks#show'].(task.id)) do |item|
          item.add_data("id", value: task.id)
          item.add_data("title", value: task.title)
          item.add_data("description", value: task.description)

          item.add_link(Routes['tasks#destroy'].(task.id), 'destroy')
          item.add_link(Routes['tasks#create'].(task.id), 'add')
          item.add_link(Routes['tasks#edit'].(task.id), 'edit')
        end

        builder.add_query(Routes['tasks#completed'], "completed", prompt: "completed tasks") do |query|
        end

        builder.set_template do |template|
          template.add_data("title", prompt: "task title")
          template.add_data("description", prompt: "task description")
          template.add_data("priority", prompt: "task priority")
        end
      end

    end.to_json

    respond_to do |format|
      format.json { render :json => json }
    end
  end

  def completed
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end
end