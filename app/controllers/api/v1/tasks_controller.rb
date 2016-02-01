class Api::V1::TasksController < ApplicationController

  authorize_resource  
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_action :set_task, only: [:update, :destroy]
  
 def create
  @project=Project.find(params[:project_id])
  @task=Task.new(task_params)
  @project.tasks<<@task
  if @project.save
    respond_to do |format|
      format.json{ render :json => @task}
    end
    else
      respond_to do |format|
      format.json{ render :json => @task.errors}
    end
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.json{ render :json => @task}
      end
    else
       render json: @task
    end
  end

  def destroy
   respond_with @task.delete
  end

  private

  def set_task
    @task=Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :done, :deadline, :position)
  end
  
end 