class Api::V1::ProjectsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    respond_with Project.where
  end

  def create 
    @todo=Project.new(project_params)
    current_user.projects<<@todo
    if @todo.save
      render :json => @todo
      else
      render json: @todo.errors
    end
  end

  def update
    @todo = Project.find(params[:id])
    if @todo.update(todo_params)
      respond_to do |format|
        format.json{ render :json => @todo}
      end
    end
  end

  def destroy
    respond_with Project.destroy_all({ :_id => BSON::ObjectId(params[:id])})
  end

  def project_params
    params.require(:project).permit(:name, :deadline)      
  end

end
